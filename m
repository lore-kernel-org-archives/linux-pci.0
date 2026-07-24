Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DEB32B106
	for <linux-pci@vger.kernel.org>; Fri, 24 Jul 2026 15:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784906653; cv=none; b=R+ubY409kCqHrIt0n9RVn/fjMqvBOLSVIctMvIauLWSuC/Q2m+96QDi4SSPf7zxudI257J/hQ5D1HoELn7nVvlzGx+aNXurdZ4Cumwqr82SyTXdZ/GvQdA7Jte2z4He+30kLbfBnBKUFQr9BuIGRTjv0INTXwStbJRKMsKVPCXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784906653; c=relaxed/simple;
	bh=2H252qxb6T+fwwtDXrORw983v0uP+BsScnahUgbjFwI=;
	h=Message-ID:From:Date:Subject:To:Cc; b=DkPDL6AfUQArYM99ixQczj8kgsYfblmsJooG/GorkuoFhPpFpej/dHJpoVt+8klR0yVyyao/hJa4o9Gk+GnDfGAHbX+ZchP+b/LMWnbmMRRDnhji4tzUfAcjFbmB7IxCEmn0u2KolmmetJDDK0ZhH3WJyCj1Ju7MUaWyfmLbHqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 1424010624;
	Fri, 24 Jul 2026 17:24:01 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id F3F0560CF04D; Fri, 24 Jul 2026 17:24:00 +0200 (CEST)
Message-ID: <cover.1784905909.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Fri, 24 Jul 2026 17:24:00 +0200
Subject: [PATCH 0/6] PCI/AER: Support Advisory Non-Fatal Errors
To: Bjorn Helgaas <helgaas@kernel.org>, Yury Murashka <yurypm@arista.com>, "Matthew W Carlis" <mattc@purestorage.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>, Qingshun Wang <qingshun.wang@linux.intel.com>, Yicong Yang <yang.yicong@picoheart.com>, dio.sun@enflame-tech.com, linux-pci@vger.kernel.org
Cc: "Mahesh J Salgaonkar" <mahesh@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, Terry Bowman <terry.bowman@amd.com>. Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Arjun Govindjee <agovindjee@purestorage.com>, Ashish Karkare <ashishk@purestorage.com>, Jasjeet Rangi <jrangi@purestorage.com>, Meeta Saggi <msaggi@purestorage.com>, rhan@purestorage.com, sconnor@purestorage.com, an.luo@enflame-tech.com, fernando.hu@enflame-tech.com, bill.wu@enflame-tech.com, xin.wang@enflame-tech.com
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

PCIe r7.0 sec 6.2.4.3 specifies that certain Non-Fatal Errors may be
signaled with ERR_COR instead of ERR_NONFATAL.  These so-called Advisory
Non-Fatal Errors are masked by default and hence not reported by Linux.

This series seeks to change that.  The meat of it is in patch [6/6].
There have been several previous attempts to support Advisory Non-Fatal
Errors which are all linked in the patch.

The preceding patches contain prep work.  In particular, they ensure that
the detecting agent and layer is reported correctly for each error (patch
[1/6] and [2/6]), simplify logging of the error source (patch [3/6]),
fix reporting of the TLP Prefix/Header Log (patch [4/6]) and move code
around (patch [5/6]).

The patches have been tested internally, but further testing would be
appreciated to raise the confidence.  Thanks!

Lukas Wunner (6):
  PCI/AER: Fix mapping of errors to agent & layer
  PCI/AER: Log agent & layer for each individual error
  PCI/AER: Deduplicate logging of Error Source Identification
  PCI/AER: Emit TLP Log only for unmasked errors
  PCI/AER: Move retrieval of FEP and TLP Log into helper
  PCI/AER: Support Advisory Non-Fatal Errors

 drivers/pci/pci.h      |   4 +
 drivers/pci/pcie/aer.c | 250 ++++++++++++++++++++++++++++++++---------
 2 files changed, 200 insertions(+), 54 deletions(-)

-- 
2.53.0

