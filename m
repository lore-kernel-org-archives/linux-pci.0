Received: from lankhorst.se (unknown [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1023DDDBC
	for <linux-pci@vger.kernel.org>; Fri, 24 Apr 2026 14:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777042264; cv=none; b=QB78RKpHqiUAMOYGulwxpWzho3VRMz6AtrlmgGIbGsa+0s0vnELOiauUCTa3sHX4cpKOgjjN5iFC8cX03gwHbZcIuDCxXxFzptsOzb/kxYTBrhLMNqa8ZEig0lApzmGOrVBXeZ320dxKQWyuW7h2VI3FvJQZvQxogLyHcOV3MJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777042264; c=relaxed/simple;
	bh=IkZ4HmVZrnr3YrXmiO7B9vcFYv7HAS2JPSowEZKO4fw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=EhVUSYYHEbBuZ9QjET3qByYma9R27/Vw1dqSFW26Wb9vr72FKWjular2Em4qAwLbdAmxJyRSC4M+nz4KlnLK958FluDFe8n2CqlvnLV2+6aHKVo0cVug+h3dm6HVeYVdnTeF4z3DH4rMRIc/2U+O/ZOMQiK1rhSpeaib5HzDdAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b=RezyCm9T; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b="RezyCm9T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
	s=default; t=1777041807;
	bh=IkZ4HmVZrnr3YrXmiO7B9vcFYv7HAS2JPSowEZKO4fw=;
	h=Date:From:Subject:To:From;
	b=RezyCm9TMidJBfoKFzHLEtwVnR7qVjIFWQMikwHEC+Ut7H2413nKoh3N1yNXSfua4
	 zjw3tIpSdB/L7JEUN4ZoMGzfLFKrLPrrSjG/S2PRBav7C3X4FIAlUYb/4bx+ZPGIrU
	 7ITHmhrEWPwaIjt3Xcn88zcwRQD1CDgoJU/HkLU+VTNmewWu6p7GDOQM8rvXMR5zMq
	 OXbSXI/8kWV8cooup4IKkSjsDCpfa65sMSulgVzChZyV/XQ6Mo28bRHda+tvykydtH
	 F6rPuZqpw5jo/56a2jGGQ8uHpfajTf+me0nPKe/M/NUFMGFCTdz+O2yxmvMwcPiaiZ
	 hdYp2c/s1Ffhw==
Message-ID: <7f673ce8-fa00-47aa-a50f-812ae5073279@lankhorst.se>
Date: Fri, 24 Apr 2026 16:43:26 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Maarten Lankhorst <dev@lankhorst.se>
Subject: [PATCH] PCI: Fix resizable bar fails due to bridge memory region
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I encountered a problem that I have on my system, where I cannot resize
the bar because one of the bridges has a 

If I take a look at the topology, the GPU shares the memory region with a bridge,

+-[0000:64]-+-00.0-[65-68]----00.0-[66-68]--+-01.0-[67]----00.0

The specific bridge likely causing a failure is:

65:00.0 PCI bridge: Intel Corporation Device e2ff (rev 01) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0, IRQ 32, IOMMU group 1
        Memory at 382400000000 (64-bit, prefetchable) [size=8M]
        ....

Which causes upstream bridge 64:00.0 initially to allocate the region
[38fe0000000-38ff0000000) for the GPU, and [382ff0000000..382ff07fffff]
for the bridge device.

Bridge 64 is big enough for 1 BMG with a 32 GB bar and the second 8 MB allocation:
pci_bus 0000:64: resource 9 [mem 0x382000000000-0x382fffffffff window] (64GB window)

The reason for failure is that bridge 65 has a 8 MB memory region assigned,
and previously it was ignored when reallocating.

Failing case:
xe 0000:67:00.0: [drm] Attempting to resize bar from 256MiB -> 16384MiB
xe 0000:67:00.0: BAR 2 [mem 0x382fe0000000-0x382fefffffff 64bit pref]: releasing
pcieport 0000:66:01.0: bridge window [mem 0x382fe0000000-0x382fefffffff 64bit pref]: releasing
pcieport 0000:65:00.0: bridge window [mem 0x382fe0000000-0x382fefffffff 64bit pref]: releasing
pcieport 0000:64:00.0: bridge window [mem 0x382fe0000000-0x382ff07fffff 64bit pref]: was not released (still contains assigned resources)
pcieport 0000:65:00.0: bridge window [mem size 0x400000000 64bit pref]: can't assign; no space
pcieport 0000:65:00.0: bridge window [mem size 0x400000000 64bit pref]: failed to assign
pcieport 0000:65:00.0: bridge window [mem size 0x400000000 64bit pref]: can't assign; no space
pcieport 0000:65:00.0: bridge window [mem size 0x400000000 64bit pref]: failed to assign
pcieport 0000:66:01.0: bridge window [mem size 0x400000000 64bit pref]: can't assign; no space
pcieport 0000:66:01.0: bridge window [mem size 0x400000000 64bit pref]: failed to assign
pcieport 0000:66:01.0: bridge window [mem size 0x400000000 64bit pref]: can't assign; no space
pcieport 0000:66:01.0: bridge window [mem size 0x400000000 64bit pref]: failed to assign
xe 0000:67:00.0: BAR 2 [mem size 0x400000000 64bit pref]: can't assign; no space
xe 0000:67:00.0: BAR 2 [mem size 0x400000000 64bit pref]: failed to assign
xe 0000:67:00.0: BAR 2 [mem size 0x400000000 64bit pref]: can't assign; no space
xe 0000:67:00.0: BAR 2 [mem size 0x400000000 64bit pref]: failed to assign
pcieport 0000:64:00.0: PCI bridge to [bus 65-68]
pcieport 0000:64:00.0:   bridge window [mem 0xd7000000-0xd83fffff]
pcieport 0000:64:00.0:   bridge window [mem 0x382fe0000000-0x382ff07fffff 64bit pref]
pcieport 0000:65:00.0: PCI bridge to [bus 66-68]
pcieport 0000:65:00.0:   bridge window [mem 0xd7000000-0xd83fffff]
pcieport 0000:65:00.0:   bridge window [mem 0x382fe0000000-0x382fefffffff 64bit pref]
pcieport 0000:66:01.0: PCI bridge to [bus 67]
pcieport 0000:66:01.0:   bridge window [mem 0xd7000000-0xd81fffff]
pcieport 0000:66:01.0:   bridge window [mem 0x382fe0000000-0x382fefffffff 64bit pref]

Working with the patch below:
xe 0000:67:00.0: [drm] Attempting to resize bar from 256MiB -> 16384MiB
xe 0000:67:00.0: BAR 2 [mem 0x382fe0000000-0x382fefffffff 64bit pref]: releasing
pcieport 0000:66:01.0: bridge window [mem 0x382fe0000000-0x382fefffffff 64bit pref]: releasing
pcieport 0000:65:00.0: bridge window [mem 0x382fe0000000-0x382fefffffff 64bit pref]: releasing
pcieport 0000:65:00.0: BAR 0 [mem 0x382ff0000000-0x382ff07fffff 64bit pref]: releasing
pcieport 0000:64:00.0: bridge window [mem 0x382fe0000000-0x382ff07fffff 64bit pref]: releasing
pcieport 0000:64:00.0: bridge window [mem 0x382000000000-0x3824007fffff 64bit pref]: assigned
pcieport 0000:65:00.0: bridge window [mem 0x382000000000-0x3823ffffffff 64bit pref]: assigned
pcieport 0000:65:00.0: BAR 0 [mem 0x382400000000-0x3824007fffff 64bit pref]: assigned
pcieport 0000:66:01.0: bridge window [mem 0x382000000000-0x3823ffffffff 64bit pref]: assigned
xe 0000:67:00.0: BAR 2 [mem 0x382000000000-0x3823ffffffff 64bit pref]: assigned
pcieport 0000:64:00.0: PCI bridge to [bus 65-68]
pcieport 0000:64:00.0:   bridge window [mem 0xd7000000-0xd83fffff]
pcieport 0000:64:00.0:   bridge window [mem 0x382000000000-0x3824007fffff 64bit pref]
pcieport 0000:65:00.0: PCI bridge to [bus 66-68]
pcieport 0000:65:00.0:   bridge window [mem 0xd7000000-0xd83fffff]
pcieport 0000:65:00.0:   bridge window [mem 0x382000000000-0x3823ffffffff 64bit pref]
pcieport 0000:65:00.0: PCI bridge to [bus 66-68]
pcieport 0000:65:00.0:   bridge window [mem 0xd7000000-0xd83fffff]
pcieport 0000:65:00.0:   bridge window [mem 0x382000000000-0x3823ffffffff 64bit pref]
pcieport 0000:66:01.0: PCI bridge to [bus 67]
pcieport 0000:66:01.0:   bridge window [mem 0xd7000000-0xd81fffff]
pcieport 0000:66:01.0:   bridge window [mem 0x382000000000-0x3823ffffffff 64bit pref]
xe 0000:67:00.0: [drm] BAR2 resized to 16384MiB


Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
---
I'm not 100% this is the correct fix, I don't know why the bridge itself has
a memory region, why the kernel allocates it and when it's supposed to
be used. Not a PCI expert. :-)
---

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 61f769aaa2f6c..98692dccc4721 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2258,6 +2258,7 @@ static int pbus_reassign_bridge_resources(struct pci_bus *bus, struct resource *
 	unsigned long type = res->flags;
 	struct pci_dev_resource *dev_res;
 	struct pci_dev *bridge = NULL;
+	struct resource *r;
 	LIST_HEAD(added);
 	LIST_HEAD(failed);
 	unsigned int i;
@@ -2286,6 +2287,21 @@ static int pbus_reassign_bridge_resources(struct pci_bus *bus, struct resource *
 				 res_name, res);
 		}
 
+		pci_dev_for_each_resource(bridge, r, i) {
+			if (!resource_assigned(r) || r->child)
+				continue;
+
+			if ((r->flags & IORESOURCE_TYPE_BITS) !=
+			    (type & IORESOURCE_TYPE_BITS))
+				continue;
+
+			ret = pci_dev_res_add_to_list(saved, bridge, r, 0, 0);
+			if (ret)
+				return ret;
+
+			pci_release_resource(bridge, i);
+		}
+
 		bus = bus->parent;
 	}
 
