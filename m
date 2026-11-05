Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.150.252.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793846712;
	b=1eJ3KQMjvKrSJ244dHniG3GGp5Nfzzp2l1+ABsJJJd3iVKLinWv5c8D+05hs7Y57Cp8x
	 2xb8P7gWMg5oVJ33AoNNz73wdYdID6LqxKuMRWXl6V/KsapG5HMqwo60Ama1TOV0ANnCw
	 QmWEQLJQpAhzP3ArI5+KDz9ANByTFKgAjxp8e1gmQ7MVjOURPggR26viC64z4EeYfPrdO
	 IMZSmCR4jl5sSiKMUF+uStxMD5wTHmOQMTDYl+O/GNiFPKM0zlaZjo8JwppOngEarvHXx
	 kJB7opPeoCLE6RyNelryNJoV58BZEOJZ4/6PHYqMEZVyST1vJYs10c4NDYXjMHCslxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793846712;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Atmail-Id:
	 X-atmailcloud-spam-action:X-atmailcloud-route;
	bh=tzFYqkW4RAckviF2FfXB9njZbc/XIgTwvUSxuoCYB0w=;
	b=Cns3XNt4ZRYfmiLqfQj8Peq6nsd/Atmzc10wWwnt4P3HvGnX2K5zw5PzkkOWb6JrZo/a
	 Qzhes0xj6IpB+xDQTcMbFHrVhjP5/UY0IzUwqlm8glQl6ioBuLY3hlZ/tWO7gtn/LAgxe
	 LYa6WYFL0OCJyw1ud9nOu9cxcnvE9WhiGxsHPajfwZotTBarVOJkOutEO7CwPCMyOM/Y5
	 hSijbdGlSWmXKCxKsc5JtpCBw1dRR3udF1wjbxjl6hmpP2m4Hj/+On3i07GHpnrKvSpHa
	 yu4FM4aPoQNhL0lfT1GYKuAttR5XoGcDDf6uNHVBumxKYS8OBcsHO+7NGNoywf3n4Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=internode.on.net;
	spf=pass smtp.mailfrom=internode.on.net;
	dkim=pass header.d=internode.on.net header.i=@internode.on.net header.a=rsa-sha256 header.s=202309 header.b=PRQ+QM6d;
	arc=none smtp.remote-ip=103.150.252.152
Received: from omr-01.pc5.atmailcloud.com (omr-01.pc5.atmailcloud.com [103.150.252.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47260606A32C;
	Thu,  5 Nov 2026 02:45:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47260606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=internode.on.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=internode.on.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=internode.on.net header.i=@internode.on.net header.a=rsa-sha256 header.s=202309 header.b=PRQ+QM6d
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=internode.on.net; s=202309; h=Content-Type:MIME-Version:Message-ID:Date:
	Subject:To:From; bh=tzFYqkW4RAckviF2FfXB9njZbc/XIgTwvUSxuoCYB0w=; b=PRQ+QM6dA
	aZyLIWoRYPrGecIJfNvLwcNFyu0UlLURj35f7jdmmUGxICDBw6kyyl5lWkXxyj981+Z1QbDFfiBNI
	od4qnIB7uE1Dtuk6XAfgSMcBN6zQVhdmCGmTrCUhxbBy+dmc94XKD5+K4svfTU6O9WC2Lsrn+v0hL
	MDLpriw/4/QKbwtCBtE9ZeIrn2yGFAP4vwN1/kOG2EMsI/PZG+eDwwbfElU1YjeKEZ1deazv0l9Yo
	TLLIgLgK1HaN2R66zFkFa4RkEkuGabJ0IEZHJz7RcrHkEEnWtEZRsvj6dOJkRzQQvxFqPhfLtzotW
	MAmzIq7oSjoEIWAPwl0sKwH8w==;
Received: from cmr-tmc.internal.pc5.atmailcloud.com (cmr-tmc.internal.pc5.atmailcloud.com [192.168.1.2]) 
	by omr-01.pc5.atmailcloud.com (Exim/cmr-tmc.i-0248c2ced204c1c85) with ESMTPS
	(envelope-from <arthur.marsh@internode.on.net>)
	id 1xOnTG-00000001cdh-2rLO ;
	Thu, 05 Nov 2026 02:44:58 +0000
Received: from 87.121.95.148.v4.dyn.launtel.au ([87.121.95.148] helo=localhost)
	 by cmr-tmc.i-0248c2ced204c1c85 with esmtpsa
	(envelope-from <arthur.marsh@internode.on.net>)
	id 1xOnTE-0000000CYFq-3Ls3;
	Thu, 05 Nov 2026 02:44:58 +0000
Received: from amarsh04 by localhost with local (Exim 4.100.1)
	(envelope-from <arthur.marsh@internode.on.net>)
	id 1xOnTD-000000000Ah-0W62;
	Thu, 05 Nov 2026 13:14:55 +1030
From: Arthur Marsh <arthur.marsh@internode.on.net>
To: vasant.hegde@amd.com
Cc: alexander.deucher@amd.com,
	bhelgaas@google.com,
	felix.kuehling@amd.com,
	iommu@lists.linux.dev,
	jgg@ziepe.ca,
	joro@8bytes.org,
	linux-pci@vger.kernel.org,
	mario.limonciello@amd.com,
	robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com,
	will@kernel.org
Subject: [PATCH v2] iommu/amd: Force identity mode for selected GPUs only
Date: Thu,  5 Nov 2026 13:14:36 +1030
Message-ID: <20261105024454.654-1-user@am64>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824085821.5422-1-vasant.hegde@amd.com>
References: <20260824085821.5422-1-vasant.hegde@amd.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Atmail-Id: arthur.marsh@internode.on.net
Authentication-Results: cmr-tmc.au-east.atmailcloud.com; auth=pass smtp.auth=arthur.marsh@internode.on.net
X-atmailcloud-spam-action: 
X-atmailcloud-route: unknown

On a system using an APU (no discrete graphics card):

model name      : AMD A10-6800K APU with Radeon(tm) HD Graphics
stepping        : 1
microcode       : 0x6001119

I was getting the following, git-bisected back to:

commit bf5bdfd1f8d4ad5c6020468d09b68b09c2adc5c2 (HEAD)
Author: Vasant Hegde <vasant.hegde@amd.com>
Date:   Mon Aug 24 08:58:21 2026 +0000

    iommu/amd: Force identity mode for selected GPUs only

I could only photograph and OCR the screen, so not a lot of data could be 
captured:

1.295232] </TASK>

1.295233] Modules linked in:

1.295237] CR2: 000000000000003c

1.295242] ---[ end trace 0000000000000000 1---

1.295245] RIP: 0010:amd_iommu_def_domain_type+0x76/0xb0

1.295250] Code: ff 25 00 7f ff ff 3d 00 00 03 00 75 cb 83 02 01 75 3f 48 81

ef do 00 00 00 48 8b 57 10 48 8b 42 10 48 85 со 74 04 48 8b 42 38 <66> 81 78 3c

32 10 74 a6 55 31 ff 48 89 e5 e8 d7 ee 3c 00 5d 83 fo

1.295253] RSP: 0018: ffffc90000027c20 EFLACS: 00010246

1.295256] RAX: 000000 RBX: ffff888100f0d5c0

RCX: 00000000ffffffff

1.295258] RDX: ffff888100dd8000 RSI: ffffffff82437607

RDI: ffff888100fc7000

1.295260) RBP: ffffc90000027c60 R08: 0000000000000001

R09: 0000000000000000

1.295262] R10: 0000000003 R11: 0000000000000001

R12: ffff888100fc70d0

1.295264] R13: 0000000000000000 R14: ffff888100aedc48

R15: 0000000000000000

1.295266] FS: 000000000000(0000) CS:ffff8884acefe000(0000) knICS: 00000

3000000000

1.295269] CS: 0010 DS: 0000 ES: 0000 CRO: 0000000080050033

1.295271] CR2: 000000000000003c CR3: 0000000002646000 CR4: 00000000000406f0

1.295274] note: swapper/0[1] exited with irqs disabled

1.295280) Kernel panic not syncing: Attempted to kill init! exitcode=0x00

30009

1.297262] ---[ end Kernel panic not syncing: Attempted to kill init! exit

ode=0x00000009 1--- 

I am happy to provide more details and test any patches.

Arthur.
