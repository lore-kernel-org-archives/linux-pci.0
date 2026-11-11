Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794440210;
	b=R44uWtMec8bCtF8sQZw0uurw2bSnnNhlRdUgKGqqM5QjE478vbSl08s+OrG0MCzLG6E2
	 4cjFxxOt+v/uMG2dFmevCUv771A72VNyzE+QvqH54xIgrmPeKFANwUDiHBREcCg1tr6Fi
	 0LuPvlSynbh/adiFMhYFrMAYyKBzv01sSizz67bmGle+juP9DcBK2y3tV7yXyfgtFNurQ
	 n8bkZGX6RJxNNTBNwBDRLtLmH4bAMv+0ty5DvBMzgmBK33qRReZWh4Cljzt9Xi3dgBEJ6
	 PSi6URCn5kc5VrIK4KegXtSrtlIYb9xOmdJtr+eIHZ7sYG11XLG3XVM1PtktoALFAEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794440210;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:Subject:X-Change-ID:To:Cc:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Message-Id;
	bh=klPxEVlV5vJD8T8vgL/Cq3QGPhsTWJ6oYKoaaEvavVc=;
	b=OzfFKYmBIwcODo3LHwnoaqYmECsQZKa1AZt2Vuh4G4/2UB+kIE723nNrWhdJTg/OYNSJ
	 S8rI65hTJV1ZKfL34lgQxGPHSYvOlRqJT/ocF5+LvxA/JVg8K7Jdzck1rRtrTOa9U5tzk
	 MBKRsY42OlWqMNyQ9GuF0bycncC9NbrjJYYcu4e3dunp9N9PaCg+wsR4xAW8AbCV/jf5q
	 NvEb8+iiLiWOFlbNWyIjHGuhr7Bs+/K2BGQ8Hi22pVKbdGNm6RXYfQKPxEcCLwrKy0toE
	 sGcbr2/EzBFw3YNGltThPRODEh9zGbII3PbaHCvfHh/Mke0vLzMmDgsfhM77atxU45w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cressey.dev;
	spf=pass smtp.mailfrom=cressey.dev;
	dkim=pass header.d=cressey.dev header.i=@cressey.dev header.a=rsa-sha256 header.s=key1 header.b=q9eETb3J;
	arc=none smtp.remote-ip=95.215.58.148
Received: from mta1.migadu.com (out-148.mta1.migadu.com [95.215.58.148])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730CB606A321
	for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2026 23:36:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 730CB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cressey.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cressey.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cressey.dev header.i=@cressey.dev header.a=rsa-sha256 header.s=key1 header.b=q9eETb3J
X-Envelope-To: linux-pci@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=jvnaHbrD3GKuc0kVTJXIvjvxRseCe9rmXMZmsYFOqy0=;
 c=simple/simple; d=cressey.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794440207; v=1; x=1795045007;
 b=q9eETb3JPeZxZBrD/mFXAIHDWksZmYd0/ZcBa/GduTVnJytZ6df6fPYIEd3Z07cXvInGRfpx
 gChdfr15HLgv4Kmt/D/KVNYn2Ss4mSLgA5UiEldYxzZrWOEt7TdrXuHEGZ7wNhQ6T2HRqOpJEfk
 yoDQ9pXEX5E4bdJz9qrQj0CtmjAUmK4y2XZKv7Dvx3aQk6fuD+Y+I0/7SdX4igt9STRdH1EzoPI
 09j/k5GXaoqLDoeIpxkmhGMFU7v4tpqS8OouNKa1dwt/KjBHrjgskVwLD1dLpsBF6ELC8tnGhZn
 vJVQfDTnzf+gk1QWpn4EvWbhw/8kR4KwprNQVIXLZa2ew==
X-Envelope-To: linux-pci@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id dba58aabdcacc9cc;
	Wed, 11 Nov 2026 23:36:47 +0000
X-Mizu-Trace-ID: dba58aabdcacc9cc
X-Migadu-Flow: FLOW_OUT
From: Ben Cressey <ben@cressey.dev>
Subject: [PATCH v2] PCI: Add ID@path device format for pci= parameters
X-Change-ID: 20260919-pci-idpath-selector-2847a8afe92c
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Logan Gunthorpe <logang@deltatee.com>, Alex Williamson <alex@shazbot.org>, 
 Wei Wang <wei.w.wang@hotmail.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 "Anthony Vardaro (Anthropic)" <me@anthonyvardaro.com>
X-Mailer: b4 0.15.2
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Date: Wed, 11 Nov 2026 15:36:31 -0800
Message-Id: <20261111-pci-idpath-selector-v2-1-83ea668e38f0@cressey.dev>

The <pci_dev> grammar shared by pci=resource_alignment=,
pci=disable_acs_redir= and pci=config_acs= names a device either by
address, with an optional path, or by ID. When one command line serves
more than one platform, neither form limits an entry to the intended
device: an address applies to whatever occupies it on each platform, and
an ID applies to every instance, such as all Downstream Ports of a
switch rather than the one that needs different ACS settings.

Accept pci:<vendor>:<device>[:<subvendor>:<subdevice>]@<path>, where
<path> is the address format, and match only when both halves match. An
entry written for one platform is then inert on another where that
address holds a different device. For example,

  pci=config_acs=xx111x1@pci:10b5:8749@0000:80:02.0/00.0/08.0

configures ACS on the Downstream Port at that path only if it is a
PEX 8749 port.

The path goes last since pci_dev_str_match_path() consumes up to the
next ';'. The IDs are compared first, and the path is parsed only for a
device that matches them. The <order>@ and <flags>@ prefixes of
resource_alignment and config_acs are stripped before
pci_dev_str_match() is called, so the callers are unchanged.

Suggested-by: Wei Wang <wei.w.wang@hotmail.com>
Signed-off-by: Ben Cressey <ben@cressey.dev>
---
Changes in v2:
- Compare the IDs first and walk the path only for a device that matches
  them. An entry whose IDs do not match skips its path up to the next
  ';', so that later entries are still read. Thanks to Wei Wang for the
  review and the suggestion.
  https://lore.kernel.org/r/SI2PR01MB4393779B4E590C6D76FD12A3DC822@SI2PR01MB4393.apcprd01.prod.exchangelabs.com
- A malformed path is now an error only for a device that matches the
  IDs. Any other device skips it.
- Rebase onto v7.4-rc1.
- Drop Anthony Vardaro's Reviewed-by, since the matching logic moved.
- Drop the Assisted-by tag. The notes below say how tools were used.
- Link to v1: https://lore.kernel.org/r/20260919-pci-idpath-selector-v1-1-5881de83f248@cressey.dev

The ID comparison is assigned to ret with the same lines as Wei Wang's
"[PATCH v10 3/6] PCI: Consolidate delimiter handling into
pci_dev_str_match()". The two conflict in that hunk, whichever is
applied second; on top of 3/6 the hunk is an 8-line insertion.
https://lore.kernel.org/r/SI2PR01MB4393A855D592C1F484DEF778DC832@SI2PR01MB4393.apcprd01.prod.exchangelabs.com

Tested under QEMU (TCG). Each of the three options selected only the
intended one of several devices with the same ID, and a later entry
still applied after one that did not match. The two ACS options were
tested on Root Ports, since QEMU's switch ports have no ACS capability.
v2 has not been run on hardware; the test on two server models in v1's
notes was of v1.

An LLM wrote the patch, the changelog and these notes, wrote and ran
the QEMU test, and ran W=1 builds of drivers/pci/ for x86_64 and arm64.
---
 Documentation/admin-guide/kernel-parameters.txt | 10 ++++++++-
 drivers/pci/pci.c                               | 28 +++++++++++++++++++------
 2 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0b3c140babd9..12b91186a1ec 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5038,6 +5038,7 @@ Kernel parameters
 
 				[<domain>:]<bus>:<dev>.<func>[/<dev>.<func>]*
 				pci:<vendor>:<device>[:<subvendor>:<subdevice>]
+				pci:<vendor>:<device>[:<subvendor>:<subdevice>]@<path>
 
 				Note: the first format specifies a PCI
 				bus/device/function address which may change
@@ -5052,7 +5053,14 @@ Kernel parameters
 				renumbering issues).  The second format
 				selects devices using IDs from the
 				configuration space which may match multiple
-				devices in the system.
+				devices in the system.  The third format
+				combines the first two: the device must
+				match the IDs and also be at the address
+				given by <path>, which takes the first
+				format.  This allows an entry written for a
+				device on one system to have no effect on
+				another system where the same address is
+				occupied by a different device.
 
 		earlydump	dump PCI config space before the kernel
 				changes anything
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7c6f2aba8144..cd5b627da88d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -343,6 +343,7 @@ static int pci_dev_str_match_path(struct pci_dev *dev, const char *path,
  *
  *   [<domain>:]<bus>:<device>.<func>[/<device>.<func>]*
  *   pci:<vendor>:<device>[:<subvendor>:<subdevice>]
+ *   pci:<vendor>:<device>[:<subvendor>:<subdevice>]@<path>
  *
  * The first format specifies a PCI bus/device/function address which
  * may change if new hardware is inserted, if motherboard firmware changes,
@@ -359,6 +360,12 @@ static int pci_dev_str_match_path(struct pci_dev *dev, const char *path,
  * legacy reasons and convenience so users don't have to specify
  * FFFFFFFFs on the command line.)
  *
+ * The third format combines the first two: the device must match the IDs
+ * and also be at the address given by <path>, which takes the first
+ * format.  This allows a parameter written for a device at a known
+ * address on one system to have no effect on another system where that
+ * address is occupied by a different device.
+ *
  * Returns 1 if the string matches the device, 0 if it does not and
  * a negative error code if the string cannot be parsed.
  */
@@ -385,12 +392,21 @@ static int pci_dev_str_match(struct pci_dev *dev, const char *p,
 
 		p += count;
 
-		if ((!vendor || vendor == dev->vendor) &&
-		    (!device || device == dev->device) &&
-		    (!subsystem_vendor ||
-			    subsystem_vendor == dev->subsystem_vendor) &&
-		    (!subsystem_device ||
-			    subsystem_device == dev->subsystem_device))
+		ret = (!vendor || vendor == dev->vendor) &&
+		      (!device || device == dev->device) &&
+		      (!subsystem_vendor ||
+		       subsystem_vendor == dev->subsystem_vendor) &&
+		      (!subsystem_device ||
+		       subsystem_device == dev->subsystem_device);
+
+		/* Third format: the device must also be at <path> */
+		if (ret && *p == '@')
+			ret = pci_dev_str_match_path(dev, p + 1, &p);
+		else if (*p == '@')
+			p = strchrnul(p, ';');
+		if (ret < 0)
+			return ret;
+		if (ret)
 			goto found;
 	} else {
 		/*

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20260919-pci-idpath-selector-2847a8afe92c

