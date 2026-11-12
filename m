Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794479127;
	b=idfno3zTo1rfALtRYhGP7PWfIaEHR5tbq73KxhkDLRiJeN063fjRBId9zgqDDRXbOQ2T
	 yJLubBSAOcABmVCSwnPHAEdJXOuDjd0qhCRZBomJDvUasOrKmv5LNpi6pBqFdinapfNDb
	 62zIhKv7Lnt0QNgDFg0RoFskjeY2KMP148S+8ovvnQcq2RApjWiF+JXjPGfW4JJ2wpBy3
	 +sNGlJAxnIVbVbVCM0SazfR7uSKGCnZMLj3P9c0sqiReQ1rZzzePTwX1HQH/letpe6EsB
	 s5f3sWt+a26Vx5UbYh6bh2KMY/nC35AbeoxoFuAylwsc/68iNWiYPDVlaJhY1hJfWTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794479127;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=lxPVBhcy06dXvZmyYLom70AEmMv9TuOdMz9vd3zbC7g=;
	b=4NPHefRwdyw3Yhce7QjFcDwndCSzm7W0w9c5//WuHOvq1wGcahhJKI38Roe21EJ10ZrD
	 P1q9BUxI4G6tzq2en4gjWe992kmWN0iZSssyN88TRTBV/gI3uy5qToldrsA3PubnC0ioE
	 2PwwQ06vARzpE66ynahK5QccznL3c0HElQPIJHw7f7xOQIgHWbaBgRbwiu+MwqopeCdlP
	 0X/XPLmbyu6mafo1kUZR/mlpWbyglG9j1SZxMXU2MMbjkBQgYz4i+mp6AerrGIRXMQr7Z
	 bzJGQXUNX0atSpGLrm7vHiTBylaj3fDt2HKYxl0ucYwKu/3fkVHFvFOB9OE1Ijx6bVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eBKokC8Y;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4008B606A327;
	Thu, 12 Nov 2026 10:25:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4008B606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eBKokC8Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794479127; x=1826015127;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=2p/RyeiAyLTxYQvMmItUdpk9jwAXyRCO4NDKMIJUjzk=;
  b=eBKokC8Yai7hobsEON8sanWVO8psRnczF7JGcyklkAP1K1GmSUI2M/7K
   vVmiwvjCknbaNTDlBzslIlMg3Ry2VF14mfAv6B9UK7Ok5hPMyYPxQwwzB
   5XgcIZvj+Yzrpb6ZFhKlVIGKIcdbI2mTwqSYsAlTnBzpOvLru1Yg7oNLW
   DolVRFTbHos0pAI7PidiszdtE7EDUaOi+EaxdMA2PBEJpk5tzGQ7lNrYb
   lUnZi5EM1T0cAyZ9nr9eDdL4TKDupzlAwaTeRanOdD+tT10sV7w63XTxc
   0tEA/wMU3DigsZLVcT6UcUCM7hFeIb7pNqacNFcUVOS3xQSrfYtb+4NDD
   w==;
X-CSE-ConnectionGUID: mpA553NiTGGpOny7wAq2Sw==
X-CSE-MsgGUID: ptpLpf7iRYuFoaCqXRVftA==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3160834"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3160834"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 02:25:27 -0800
X-CSE-ConnectionGUID: qCkVLhX8S0exzL3CKAvgRw==
X-CSE-MsgGUID: SPIvEvuxSMyYa6gVmNCZFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="10352881"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.68])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 02:25:22 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 12 Nov 2026 12:25:19 +0200 (EET)
To: Hans Zhang <18255117159@163.com>
cc: bhelgaas@google.com, mani@kernel.org, lpieralisi@kernel.org, 
    kwilczynski@kernel.org, thierry.reding@kernel.org, ryder.lee@mediatek.com, 
    jonathanh@nvidia.com, robh@kernel.org, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux-mediatek@lists.infradead.org, 
    linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 1/5] PCI: Use pcie_get_link_speed() in pci.c
In-Reply-To: <20261112022405.1230200-2-18255117159@163.com>
Message-ID: <0c4e7529-c658-f841-8967-d32252e83dc5@linux.intel.com>
References: <20261112022405.1230200-1-18255117159@163.com> <20261112022405.1230200-2-18255117159@163.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-844207116-1794479119=:1181"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-844207116-1794479119=:1181
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 12 Nov 2026, Hans Zhang wrote:

> Replace the to_pcie_link_speed() wrapper with pcie_get_link_speed() in
> pcie_link_bandwidth_mbps() and pcie_bandwidth_available(), and remove
> the now-unused wrapper.  pcie_get_link_speed() performs the same lookup

now unused

I suppose Bjorn can take care of that while applying so no need to send=20
another version because of this alone.

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

> with bounds checking and is already exported.
>=20
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>  drivers/pci/pci.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 7c6f2aba8144..594ee7aa4cad 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6025,11 +6025,6 @@ int pcie_set_mps(struct pci_dev *dev, int mps)
>  }
>  EXPORT_SYMBOL(pcie_set_mps);
> =20
> -static enum pci_bus_speed to_pcie_link_speed(u16 lnksta)
> -{
> -=09return pcie_link_speed[FIELD_GET(PCI_EXP_LNKSTA_CLS, lnksta)];
> -}
> -
>  /**
>   * pcie_link_bandwidth_mbps - get the current bandwidth of a single PCIe=
 link
>   * @pdev: PCI device to query
> @@ -6041,14 +6036,15 @@ static enum pci_bus_speed to_pcie_link_speed(u16 =
lnksta)
>   */
>  int pcie_link_bandwidth_mbps(struct pci_dev *pdev)
>  {
> -=09u16 lnksta;
> +=09u16 lnksta, lnksta_cls;
>  =09int speed, err;
> =20
>  =09err =3D pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta);
>  =09if (err)
>  =09=09return pcibios_err_to_errno(err);
> =20
> -=09speed =3D pcie_dev_speed_mbps(to_pcie_link_speed(lnksta));
> +=09lnksta_cls =3D FIELD_GET(PCI_EXP_LNKSTA_CLS, lnksta);
> +=09speed =3D pcie_dev_speed_mbps(pcie_get_link_speed(lnksta_cls));
>  =09if (speed < 0)
>  =09=09return speed;
> =20
> @@ -6074,7 +6070,7 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, s=
truct pci_dev **limiting_dev,
>  =09=09=09     enum pci_bus_speed *speed,
>  =09=09=09     enum pcie_link_width *width)
>  {
> -=09u16 lnksta;
> +=09u16 lnksta, lnksta_cls;
>  =09enum pci_bus_speed next_speed;
>  =09enum pcie_link_width next_width;
>  =09u32 bw, next_bw;
> @@ -6089,7 +6085,8 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, s=
truct pci_dev **limiting_dev,
>  =09while (dev) {
>  =09=09pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
> =20
> -=09=09next_speed =3D to_pcie_link_speed(lnksta);
> +=09=09lnksta_cls =3D FIELD_GET(PCI_EXP_LNKSTA_CLS, lnksta);
> +=09=09next_speed =3D pcie_get_link_speed(lnksta_cls);
>  =09=09next_width =3D FIELD_GET(PCI_EXP_LNKSTA_NLW, lnksta);
> =20
>  =09=09next_bw =3D next_width * PCIE_SPEED2MBS_ENC(next_speed);
>=20
--8323328-844207116-1794479119=:1181--
