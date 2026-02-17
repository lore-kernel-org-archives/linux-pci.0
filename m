Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8AB34D4F8
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 16:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771344538; cv=none; b=SPdel8Hz4lPM3xxXgh78JVDBDn9bjPNa4cU6GbmmFVLRTo/YF9Y8Pj3YAg+ensr1ic8lOSdhiKJLueMsspqnGwtq85OwL9gfRJvUD6QydzVKtJGJToFb3jqXrJuUS7DlUgMjOZEPmVI8oEqdXYVbylR7Ph3BR1BF+E9InHHed0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771344538; c=relaxed/simple;
	bh=+QLhHTb/5WCShdm7aJysxsh21rUg6QAbVvR1WVUV/3E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=urq+rKQLbKfoYc3nxoOitzLM+I5bMM1qVmC9MVmvl2Xcjal7R8bbZ8RoPZ0HqyQ8mjlnkfAc1e5wXMA8E2Vr7C09KCj6mowNrugHzwMAPn7sX6jNxFATJ09+HeITJwuxS0Xw+xNYrbhf9lZGrmTAqkj8uOby7Gct76IKwHXH3oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=c5NsGo/N; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="c5NsGo/N"
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 61HEqw06545977
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 08:08:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=4hue1uQO4tWvAph7y2
	OqQEQYhPJ4kFv4dZ4pBmeUiVY=; b=c5NsGo/NKz0qanALLwl468ypRcA0GWGA+4
	JgswcXma177TiEJh/Km07dn13BfGLRWSF0qaPxG/UM8VjEiFvUO1otIVZxgiOBvs
	cC1ZbQUPFuhpYGM7KVXkqpcWuc4K2wK987KIkStEZjs4BPW92S7wmbWu651Ol4ia
	tFv2nrffKMOqr52UUiQayLeql7zR5EaNTOOBfdELtO2WLhxjzKDLR9zyP7ShQmhN
	HLg4CjCkmfH8oRI/HNo6yWeTKNtf6QAl8trCirmYZwGA07Hn8DqAl1WevcPpYvbN
	vmyvm0xznNPiRrDxvLFESzoZ2H4eTP8KLq4UjZDqyzTuD70Qiaqg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4cctg217ja-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 08:08:56 -0800 (PST)
Received: from twshared18017.01.snb2.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Tue, 17 Feb 2026 16:08:54 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 55AB0811FAF7; Tue, 17 Feb 2026 08:08:39 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-pci@vger.kernel.org>, <helgaas@kernel.org>,
        <dan.j.williams@intel.com>
CC: <alex@shazbot.org>, <ilpo.jarvinen@linux.intel.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv5 0/3] pci slot reset handling fixes
Date: Tue, 17 Feb 2026 08:08:33 -0800
Message-ID: <20260217160836.2709885-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDEzMSBTYWx0ZWRfX+HY55r4wHk0E
 l+zXy4tXZ1Hesv0u/xIF/uf82h7NWD/e/zoP4EvTiSKA8sR5vdArrq4IHASI5HnvwPZ4W5ZnstD
 H+etKfVIGTtxQ1kxLCwO1rbbGFBSqOyolC9N3m5dSxn+G1wu/myazitTe3abSg0VnerKG2Jv8J0
 n+WVAy3OF4iWgT1szQnxP++x6vKJFSnNbOVUoUm5vOTka7CLmCmUtyqoqboO8MMB6iTkPzxPkk0
 9DKacGMXhcqTWdO1XAdy8wtZGEZMuPRnqc8yckglcQsz3emYi6dm7Hknfw4SFeBEVsTcBKD7iAD
 chLo3UeGqfWrvbAdKCKszXyqx1zEdqEOe0dRXYw8nPbR5PGDqbHgGmKSQivicL/AOU1CbXJ8sth
 tdSmzS5sqvH3e+ctxky1oZvwVkPbR1O8fIsdEppXPQv6lnlQd9P8/JO/o1+O2bRZjwp1RFey4Pq
 NdrqFoTzjREdusYIvLw==
X-Authority-Analysis: v=2.4 cv=RbWdyltv c=1 sm=1 tr=0 ts=69949298 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=3IWuNq70jU1TmibXWOcA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: LkRdJsNLmTVdREx5ZwTIwiozKuGiQugL
X-Proofpoint-GUID: LkRdJsNLmTVdREx5ZwTIwiozKuGiQugL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_02,2026-02-16_04,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

Previous version:

  https://lore.kernel.org/linux-pci/20260212224112.1913980-1-kbusch@meta.=
com/

Changes from previous version:

  * Fix subject line to match convenction (s/pci/PCI)

  * Added example kernel panic logs for fatal hardware errors observed
    without the slot handling fixes

  * Rearraged some code in the last patch to avoid the need for a
    forward declaration.

  * Expanded on the comment explaing the difference between the
    restore values for the bridge reset

Keith Busch (3):
  PCI: rename __pci_bus_reset and __pci_slot_reset
  PCI: allow all bus devices to use the same slot
  PCI: make reset_subordinate hotplug safe

 drivers/pci/hotplug/pciehp_core.c |  3 +-
 drivers/pci/pci-sysfs.c           |  3 +-
 drivers/pci/pci.c                 | 97 ++++++++++++++++++++-----------
 drivers/pci/pci.h                 |  2 +-
 drivers/pci/slot.c                | 27 +++++++--
 include/linux/pci.h               |  8 ++-
 6 files changed, 97 insertions(+), 43 deletions(-)

--=20
2.47.3

