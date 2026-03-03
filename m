Received: from mx-relay100-hz2.antispameurope.com (mx-relay100-hz2.antispameurope.com [94.100.136.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B741A6801
	for <linux-pci@vger.kernel.org>; Tue,  3 Mar 2026 12:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.136.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772541546; cv=pass; b=p9n/Kw0b7uDaP+Cr2ktlukmDwzt2XlT44XNZPNLlspNCREKVgnUKpZ8ulMSobcWYlikhXnRYV4teNZ+pRMl3gezdgFvwv8TKzpB3SdyhQb/jmoivgpd25PymubUqkLZCqWpeEVUymkQ1OpcJy82AisHQcFpaRqIeYKcwAB3O6f8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772541546; c=relaxed/simple;
	bh=EhOFLiDAZMEmzb83dQYayfEKstu3tlm0p7ycV6i5JPs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e7p0VtXuU5PLs7EUpry6ymjJlXCKXiN9ZRkexe0SkgqvZnMbbGmt6lSns4K+O2QRjHz1sjY//7RVGz371sr7nnIR5ixLlD1oY2G8EADo6hPbRskR+LJ3blqC1z6P8LCixgz4DU5MV0HwbMNVs2IPjz4fFnx5rM/ev3PTg6Sf6W4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=e7aTSiI+; arc=pass smtp.client-ip=94.100.136.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="e7aTSiI+"
ARC-Authentication-Results: i=1; mx-gate100-hz2.hornetsecurity.com 1;
 spf=pass reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out04-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=lWwoqo46Zr/3jyyKrQqeEXquRAWf+PTNX5MMsSlQxIA=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1772541502;
 b=CUTh6HYvmJQUjbDEcKNhifLJOabx93zlFveojnJRLvaefKeT+9KwUfKlrPmCbTN+ZRvsvwR1
 jitvy3L5uyYYebGoFVjS/+kkf63+R3DkXqf4OCmB6+yxY2avDhf0gHcqjJtDJ1uotIB38P3570f
 r2J89o+cLfdl5deUdH4UyO5OClcFF72X2++ajxxkloHZtU3HnX3hj6QhnNnYebng+e15CieTzu9
 KsYjSVNlIV1Yc2veAYRlLiEEjcdzQvx5zp8HjU/XW/rk49lvM4CLhiLhiNleKKvCFu4O2AaW9Pj
 t+v5E2X1xbexAyOhh60OEI0npBKx1WncLFjlFJRr/78Xg==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1772541502;
 b=H2/lH7TibYfGVcJEewSXlpops81poPsfNTjzjczDXPrD7lVWPE6K3pDxEGw0zwKSVxXVvIZz
 FkuE5/gGE6GXVe/zelRXZu8r/pW402IB8bknyN2QAxMtM2Gb4e55JAeXcqnwHB2M3FPyCJQQ5MA
 Uts9NQgZo2V4OOziyY1fo4QY3yipUMETx53NJMgJ4KlsPCw7ZykZNDHNK9YIqMp0g3XBeGpa99x
 L3Y24JgcpPu7nB8FWc5vtx3HMCizOXNvksJ/8+Zo6rpd9kGP4mxSzZzt93s/cICYZLqVKrU96Dx
 v44w3S+M4M5Pvv3syP1pqXOGjICPr0wEmXH6vW9yU/zrA==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay100-hz2.antispameurope.com;
 Tue, 03 Mar 2026 13:38:22 +0100
Received: from steina-w.localnet (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: alexander.stein@ew.tq-group.com)
	by hmail-p-smtp01-out04-hz1.hornetsecurity.com (Postfix) with ESMTPSA id AA64E220B43;
	Tue,  3 Mar 2026 13:38:13 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev, Richard Zhu <hongxing.zhu@nxp.com>
Subject: i.MX8M Plus PCIe link regression
Date: Tue, 03 Mar 2026 13:38:13 +0100
Message-ID: <23024521.EfDdHjke4D@steina-w>
Organization: TQ-Systems GmbH
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-cloud-security-sender:alexander.stein@ew.tq-group.com
X-cloud-security-recipient:linux-pci@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: alexander.stein@ew.tq-group.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay100-hz2.antispameurope.com with 4fQFhP74nLz3PJhp
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:850274fae2b2e7370f7fd9100b832d79
X-cloud-security:scantime:1.471
DKIM-Signature: a=rsa-sha256;
 bh=lWwoqo46Zr/3jyyKrQqeEXquRAWf+PTNX5MMsSlQxIA=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1772541501; v=1;
 b=e7aTSiI+VoiWT4YZdNxds/pcwk5i7JIgu5a79hmLeW4FuaObn3lX1FuAnWsK4Q1u7i7j5IMt
 1SinjHYB2rP9VlbIJ2PlWp6eLGMA76pNVp8isxanIY1qzE4p6zPNuiK1IeDvghG2q0tc5NEQf/c
 5CM01Xpcf8U3qa4fL6EP2dCRemCrVq9eAqB792rPgivIq1GCER0Dm4cPBXUsTT0UcI934MOLsD8
 11WCHWqKx8a9tlc/BU5UgjuRcVpZHWl1S6FfYPQlnm7eJ2VxHSJkEJJUckS1ARcKlFDLK573UYO
 CPgeIC0nVj3XlTeulffq+FQh7saecRKDNAbZOycwXZhrg==

Hi,

these days I noticed that there is a PCIe link regression on my i.MX8MP
platform (TQMa8MPxL) running next-20260227.
I could bisect it back to commit 9c03e30e3ade3 ("PCI: imx6: Skip link up=20
workaround for newer platforms"). I always get the following errors:

imx6q-pcie 33800000.pcie: Link failed to come up. LTSSM: CFG_LINKWD_START
imx6q-pcie 33800000.pcie: probe with driver imx6q-pcie failed with error -1=
10

Connected is a Gen1 PCIe -> Ethernet adapter. Interestingly a Gen2 device is
detected without issues.

Reverting 3c96a61dd2e098dda8dcac3dce3d38a3c87afbfc and
b9a8d28ebbf118bb3eac953f4a37abbd341257ab "fixes" my platform, both Gen 1 and
Gen 2 devices are detect. Commit 3c96a61dd2e098dda8dcac3dce3d38a3c87afbfc i=
s only
required for conflict free revert.

Here is a summary with outputs:
Gen 1 device
> 00:00.0 PCI bridge: Synopsys, Inc. DWC_usb3 / PCIe bridge (rev 01)
> 01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
> RTL8111/8168/8211/8411 PCI Express Gigabit Ethernet Controller (rev 01)

Gen 2 device
> 00:00.0 PCI bridge: Synopsys, Inc. DWC_usb3 / PCIe bridge (rev 01)
> 01:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9128 PCIe SATA=
 6
> Gb/s RAID controller (rev 20)

output of "dmesg | grep imx6q-pcie". Common part for all tests:
> imx6q-pcie 33800000.pcie: host bridge /soc@0/pcie@33800000 ranges:
> imx6q-pcie 33800000.pcie:       IO 0x001ff80000..0x001ff8ffff ->
> 0x0000000000
> imx6q-pcie 33800000.pcie:      MEM 0x0018000000..0x001fefffff ->
> 0x0018000000
> imx6q-pcie 33800000.pcie: config reg[1] 0x1ff00000 =3D=3D cpu 0x1ff00000
> imx6q-pcie 33800000.pcie: iATU: unroll T, 4 ob, 4 ib, align 64K, limit 16G

next-20260227
Gen 1
> imx6q-pcie 33800000.pcie: Link failed to come up. LTSSM: CFG_LINKWD_START
> imx6q-pcie 33800000.pcie: probe with driver imx6q-pcie failed with error =
=2D110

Gen 2
> imx6q-pcie 33800000.pcie: PCIe Gen.2 x1 link up
> imx6q-pcie 33800000.pcie: PCI host bridge to bus 0000:00

next-20260227 + reverts
Gen 1
> imx6q-pcie 33800000.pcie: PCIe Gen.1 x1 link up
> imx6q-pcie 33800000.pcie: PCIe Gen.1 x1 link up
> imx6q-pcie 33800000.pcie: PCI host bridge to bus 0000:00

Gen 2
> imx6q-pcie 33800000.pcie: PCIe Gen.1 x1 link up
> imx6q-pcie 33800000.pcie: PCIe Gen.2 x1 link up
> imx6q-pcie 33800000.pcie: PCI host bridge to bus 0000:00

What can we do here? I'm wondering why Gen 2 trains correctly, while Gen 1
doesn't.

Best regards,
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


