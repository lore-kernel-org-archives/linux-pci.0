Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=50.112.246.219
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795445083;
	b=FnyYbh/nzKD2m2n12FxUdZoPfUxKTWbICuVrpHmRILP1MtD+6uxWF2bhDM9kRwAv050S
	 2x9xEoiQgvwIsYWvzreq6TWPqGLTU0KpO7PSE9cVjyel3R7KDDFjQ043aLDyKlrmkl7o+
	 sWdZqz2/3qj/DVVq+EsAmNushQwUuPAnphI5qSFr8MEWxzCWIlBeRvqP6i+oqiC2zM5Wo
	 dUzryJpKEIaXpxHygaTMQF7Cd7VPH9wPYxqsfPH+gklp7uthIJI0DGivIPQfr7hOtJJkg
	 BAU+IbS4PUxuEgfrCrkIODIgWZpSv3zdlIeV3utlyq5VAZ/U2x4WH3d3wg2ETngssOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795445083;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=9kpiQrp5Xf4cNJSbIcuRML7We1PAF0l0XmCp3ST/zdk=;
	b=W20iWGuRV+mhZsBrqnKj1rTcYaLL+ngAArxLVLoXIW32m8qy3+E1wS1K+D1jOZ0IaWF1
	 UjLXhdhY/V4Tz+LLr+rP4J216SnHsIjoWUY3NGd05s/eSTpTiC2Xt0aepjNLCuhstnkDL
	 kBJGZ+SbMwDlED1X4OgLAZTX0gF42+McqM6jEbK0fUcpX+a8bMIttFJ2fJvKSSy7wik8T
	 SWGHAjJDxAl5E/NN8jvlg9U3dPuLEBoRCI5K1zLlhGqoW0r+T6O5QSpGAwVtrw8uqa6NT
	 9rm4hL5f5EeOTALOyLsR+/p9BaG9AUhO7Ldf95uSqbcZRj8eh/pTfFWCGdw2w4hoD0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.de;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=QuPPozBV;
	arc=none smtp.remote-ip=50.112.246.219
Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com [50.112.246.219])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F193606A31A;
	Mon, 23 Nov 2026 14:44:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F193606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=QuPPozBV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1795445083; x=1826981083;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9kpiQrp5Xf4cNJSbIcuRML7We1PAF0l0XmCp3ST/zdk=;
  b=QuPPozBVuo6m/GuAR2nnBunE0e1mt/NNHJu8azcRjk5hj01fFYP3NQeR
   O+guPm9wp29TZX0D/SCoGDwPextBQZ8Su3MSF0OmB1Lx7T9hlJfWc7Y0h
   ENG7+O/d+FgVnd2Srru2P1Ihx30AjTXnsWCpT+NBX+HVIoCiv9+bNHT5+
   PxSi1xNLnUpO+uZf9V9+dtplhVirsmqE5oo9rak2hWUdIRj6DirpA4n6O
   4SRrabl6mmmYaEUjPQgfmyHwzrrkzqUCJE1lr5e4/geRXz6NzNMy581sq
   ikuG7Eqw9mj7jZhZ104qta4BIoZ11D9qF2ll7Cvl2/YhQMwXRK2dhL1B1
   A==;
X-CSE-ConnectionGUID: w0chaxydSze1TEgfpTZfkw==
X-CSE-MsgGUID: U+8redVxR3qBocccH19lIg==
X-IronPort-AV: E=Sophos;i="6.27,229,1787011200"; 
   d="scan'208";a="34716044"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 14:44:40 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:31150]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.36.222:2525] with esmtp (Farcaster)
 id 3af46666-5a8b-477f-8b37-df9961a87778; Mon, 23 Nov 2026 14:44:40 +0000 (UTC)
X-Farcaster-Flow-ID: 3af46666-5a8b-477f-8b37-df9961a87778
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.57;
 Mon, 23 Nov 2026 14:44:40 +0000
Received: from dev-dsk-doebel-1a-7b355d76.us-east-1.amazon.com (10.169.119.5)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.57;
 Mon, 23 Nov 2026 14:44:39 +0000
From: Bjoern Doebel <doebel@amazon.de>
To: Bjorn Helgaas <helgaas@kernel.org>, Manivannan Sadhasivam
	<manivannan.sadhasivam@oss.qualcomm.com>
CC: Lukas Wunner <lukas@wunner.de>, Konrad Dybcio <konradybcio@gmail.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [REGRESSION] PCI: d4c79b63d82d4 "Allow D3 for native Hotplug capable Root Ports on non-x86" silently breaks surprise hotplug on empty slots
Date: Mon, 23 Nov 2026 14:44:21 +0000
Message-ID: <20261123144424.4164268-1-doebel@amazon.de>
X-Mailer: git-send-email 2.50.1
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA002.ant.amazon.com (10.13.139.96) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Hi Bjorn, Manivannan,

Commit d4c79b63d82d4 ("PCI: Allow D3 for native Hotplug capable Root
Ports on non-x86 platforms") breaks surprise hotplug on empty slots on
AWS Graviton bare metal. I didn't find this failure mode covered in
the existing discussion, but am leaving links to related reports
at the end.

Observation (m7g.metal, aarch64, native PCIe hotplug via _OSC): ENI
(Elastic Network Interface) attachment hot-adds an ENA NIC behind one
of the hotplug-capable Switch Downstream Ports, which are all empty at
boot. Since d4c79b63d82d4, those ports runtime-suspend to D3hot shortly
after boot (all 45 empty ports report "suspended" in
power/runtime_status), and a subsequent ENI attach produces no event
at all: no "Card present" from pciehp, no ACPI/GPE activity, no new
device, no error anywhere. Ports with live children stay awake, so
only devices attached after boot are affected.

The device itself is fully present behind the suspended port: with the
ENI attached and the event lost, a manual

  echo 1 > /sys/bus/pci/rescan

enumerates and probes it normally. So the hot-add completes in hardware,
but we lose the event delivery. From code reading, the port suspends
with the hotplug interrupt disabled (pciehp_runtime_suspend() ->
pciehp_disable_interrupt()) and nothing wakes a port with an empty slot.

Functionality works on 7.2. It also works if I manually disable D3
via pcie_port_pm=off and if I revert d4c79b63d82d4.

  kernel                                     empty ports    result
  ------------------------------------------ ------------- ----------
  7.2-based (before this commit)             active        PASS
  7.3-based (contains this commit)           suspended     FAIL
  7.3-based + pcie_port_pm=off               active        PASS
  7.3-based, only this commit reverted       active        PASS

This failure reproduces deterministically in our CI.

Related reports referencing this commit:

  - system suspend crash on Qualcomm SC8280XP CRD:
      https://lore.kernel.org/all/3eeb3465-a1e6-4fdc-8019-3907d9c55691@gmail.com/

  - commit recommended as a D3cold fix in the qcom hotplug thread:
      https://lore.kernel.org/linux-pci/1ae8d4f0-1c32-4dbd-a18e-7a2ce2627efc@oss.qualcomm.com/

Happy to try out any suggestions on how to proceed fixing this.

Best,
Bjoern
