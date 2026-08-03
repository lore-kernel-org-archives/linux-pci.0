Received: from mail.nsa.green (mail.nsa.green [78.28.212.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB8A375AC6
	for <linux-pci@vger.kernel.org>; Mon,  3 Aug 2026 10:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.28.212.254
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785751832; cv=none; b=O7TVAkejNS+5PGwqo/YoID9h670QQgEKnLYxwy29+QXUJ3FVjIwsYu6Ur/e5KFXCabGYVN0hskAcCT/Zc0JXPDVtCweutGuoG/hWwNzXliL1G/FPo7d2x/i9SB3UZuWrbznc5KrCeacQyEXL3yAnxZkYyQSRZ5GPkRnHyXmPcNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785751832; c=relaxed/simple;
	bh=/6OoWI9azDAUP2a9mumL5IdlRhDmXcAKVcfp9+A8Ybw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GJnInPnxgvbGAllXpPPuNtk1qbHrfU6ooyj/9fIxy5aUBS7bSn9E5w6I7kNwXimacPKp/SZTXMo+wSFLgQVDLZVzpNwxz35rv7n7tm+9VugEHZa1wCS4gJhBdY61FaXWB+eRKdIXewvdtZmD01ezN2coYDsFeaZqt9C8Ff5dHrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nsa.green; spf=pass smtp.mailfrom=nsa.green; dkim=pass (2048-bit key) header.d=nsa.green header.i=@nsa.green header.b=bclWS5ve; arc=none smtp.client-ip=78.28.212.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nsa.green
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nsa.green
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nsa.green header.i=@nsa.green header.b="bclWS5ve"
Authentication-Results: mail.nsa.green;
	dkim=pass (2048-bit key; unprotected) header.d=nsa.green header.i=@nsa.green header.a=rsa-sha256 header.s=dkim header.b=bclWS5ve;
	dkim-atps=neutral
Received: from mailserver.lev (localhost [127.0.0.1])
	by mail.nsa.green (Postfix) with ESMTP id 4hDC9H6g5yzFsjB
	for <linux-pci@vger.kernel.org>; Mon,  3 Aug 2026 13:10:27 +0300 (EEST)
Authentication-Results: mailserver.lev (amavis); dkim=pass (2048-bit key)
 reason="pass (just generated, assumed good)" header.d=nsa.green
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nsa.green; h=
	content-transfer-encoding:mime-version:message-id:date:subject
	:to:from; s=dkim; t=1785751827; x=1786615828; bh=/6OoWI9azDAUP2a
	9mumL5IdlRhDmXcAKVcfp9+A8Ybw=; b=bclWS5veV4lfyQgW9nuoYS7O9JMMoDV
	PzS8xYEncZCtUxCV2DPVoNlTBhYphh0mxNLTMeFm5F+3LRD6FpIKlUzNd7JjeeoN
	lsjpFdtCvgqaz9DHGjNHBCHYWYHBUPdtf9cCT6T2K+86aE6USXzMPF/4NBm31o09
	MeQRgi3/X+PQNO+8Z7rrli1HelHK4spoCsKphsemImem45H8wzcGAMGfiC0X03jh
	OxNZrHA62JNZuOENpW2VOjweRnn1YduNNovLF1TrRnjqFIM7Vbtdb3tTCFyYcW5r
	WlO6bjp/QnDMwb3CMXSovRQM5L9CnNNc+RQwF6Bl3KTfH0+gjYJzlFg==
X-Virus-Scanned: Debian amavis at mailserver.lev
Received: from mail.nsa.green ([127.0.0.1])
 by mailserver.lev (mailserver.lev [127.0.0.1]) (amavis, port 10026)
 with ESMTP id s1yI2eixcRUp for <linux-pci@vger.kernel.org>;
 Mon,  3 Aug 2026 13:10:27 +0300 (EEST)
From: Igor Sakulin <is@nsa.green>
To: Xincheng Zhang <zhangxincheng@ultrarisc.com>,
	Jia Wang <wangjia@ultrarisc.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: PCI: dwc: ultrarisc: why 32-bit-only config accessors for own config space?
Date: Mon,  3 Aug 2026 13:10:11 +0300
Message-ID: <20260803101015.43548-1-is@nsa.green>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

A question rather than a bug report - I do not know the hardware well
enough to say which way this should go, and it would be easy to "fix" it
into something worse.

On a Milk-V Titan V1.2 (UltraRISC DP1000) running v7.2-rc5, each of the
three root complexes prints, once per bus:

  pci_bus 0000:00: 2-byte config write to 0000:00:00.0 offset 0x8c may co=
rrupt adjacent RW1C bits
  pci_bus 0001:00: 2-byte config write to 0001:00:00.0 offset 0x8c may co=
rrupt adjacent RW1C bits
  pci_bus 0002:00: 2-byte config write to 0002:00:00.0 offset 0x8c may co=
rrupt adjacent RW1C bits

That comes from pci_generic_config_write32() in drivers/pci/access.c, whi=
ch
warns because it has to do a read-modify-write for anything narrower than=
 a
dword.

The reason it is reached is that pcie-ultrarisc.c replaces the DWC defaul=
t
ops for the root port's own config space:

  drivers/pci/controller/dwc/pcie-ultrarisc.c
    static struct pci_ops ultrarisc_pci_ops =3D {
            .map_bus =3D dw_pcie_own_conf_map_bus,
            .read =3D pci_generic_config_read32,
            .write =3D pci_generic_config_write32,
    };

  drivers/pci/controller/dwc/pcie-designware-host.c
    static struct pci_ops dw_pcie_ops =3D {
            .map_bus =3D dw_pcie_own_conf_map_bus,
            .read =3D pci_generic_config_read,
            .write =3D pci_generic_config_write,
    };

Same map_bus, but the sized accessors are swapped for the 32-bit-only
ones, and there is no comment saying why.

So: is the DP1000 DBI genuinely unable to honour byte enables?

If it is, the override is correct and I would only suggest a short commen=
t
above ultrarisc_pci_ops saying so - it is exactly the sort of thing the
next person to read this file will otherwise try to "clean up", and the
kernel's own warning invites them to.

If it is not, this is worth changing, because the warning is describing a
real hazard rather than a theoretical one. In this root port the PCIe
capability sits at 0x70, so the warning's own example is benign - offset
0x8c is Root Control and the adjacent half at 0x8e is Root Capabilities,
which is read-only. But the same accessors cover the whole of the root
port's config space, including:

  0x78  Device Control (16-bit) + Device Status (16-bit, RW1C) at 0x7a
  0x80  Link Control   (16-bit) + Link Status   (16-bit, RW1C) at 0x82
  0x88  Slot Control   (16-bit) + Slot Status   (16-bit, RW1C) at 0x8a

(AER is not in that list - its status registers are RW1C, but they are
32-bit and get 32-bit writes, so they never take the read-modify-write
path.)

Both Device Control and Link Control get 16-bit writes in the ordinary
course of business - pcie_capability_clear_and_set_word() from MPS/MRRS
configuration and from ASPM - and each one silently clears whatever bits
happened to be pending in the status register next to it: the error bits =
in
Device Status, and Link Bandwidth Management / Link Autonomous Bandwidth
Status in Link Status. On a machine being brought up for RAS work that is
not a happy failure mode, and it is invisible - the warning fires once pe=
r
bus and says nothing about the writes that follow.

I have deliberately not tried to answer this experimentally. Proving byte
enables work needs writing to the DBI from a test module and checking tha=
t
the untouched half of a dword survives, and every register I would want t=
o
poke on a live root port is load-bearing. If you can point me at a
register that is safe to write on this SoC, I am happy to run the test an=
d
report back - I have the board and a working serial console for it.

For reference, the board: 8 harts, 62 GiB, three RCs; the x16 slot has a
Mellanox Connect-IB in it training at Gen3 x16 with 17 MSI-X vectors, so
the controller is otherwise working well.

Thanks,
Igor Sakulin <is@nsa.green>
