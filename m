Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793984844;
	b=TrYVN5tA1mWA5Gm6wIq+tS40lqrGTMF5mEkR5bJZNT7iEocG7+v4VbEchrjj0wFvjYsD
	 67FW+VfHzF9U2m7Frtz50aOl0yI7grLpFdQ6FRN9LCVmzn493m4MeSllvMxFX5uZOh40h
	 6YiT+2s2GD4MJapPiOEyYhfj8mIWDisD/MGt5cVYXLLl9/rPqoZR+6tZnpa3CmplqMtpL
	 VoKCIwVNCm2HiShOnJBY6KW+cQsADq2pOvGL6Rgy/ltSjwUamt2vbrsfonBMec7ytF8+t
	 Zunl2fvfD2XMZDtI6scRXUpsS4IyJwWj+K8hxvLkYDicFQmv6ZFJQ8+lX64onSkSeuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793984844;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=h4wLrSGHj4slcS32zD5Mhy8jbQmXlZ0LxI54YGq/KDU=;
	b=KqKU++VbVi8hB6UZldyF8uMHR21kHTUykVYhSoiszW5aLrAsTrTBzzrX9dX9v4E6kpZT
	 ZCs4RflXfMYuucm4qdJsVVabSN6og/fhWQdq8/w+hr+y4HGiID3jEr0KbQMFBTvlhYzbx
	 DG56I0kCEX0cMDfhSWiOFV2u0m3wlTTnKgb/42GfS3ML2lGGrZWBQUFfMlxPYIsc3cCZW
	 DmSWiKAa6Ml9K7pJpIEANGJ2XCU38VBEfQ1WdJPBgaTbF2SiQj1ZCC5xvSYIuvdhBp5Gg
	 aCV/58zSAAHV2zxoW/AGO9s1U8qf8HvcarNIfYYDHX9Tw2HfV2Lm6jX4YkQo8PxEEWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XE62YSX9;
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91412606A326
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 17:07:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91412606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XE62YSX9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793984844; x=1825520844;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=o72H/k4m8RggJftGbHKGzjcIpYaBMrB/bAouRtVXLdw=;
  b=XE62YSX9FY+XWX7UTc67rCNx9Ln6jMA+a5U41mZL9MOmO0c67Rewu8pZ
   b43iRNOi9vu5RILA5wnblwWRBrxw3oNKYoIfIBXg0GrezRKCpfyow6Iav
   3coYglI9tZbWu1qPZYUj21DlfDJFE/DV2RDRx6I9nmnBb/4ofQRnBiL6q
   kQ6pbv7YOG0LSmwxIdwkZGtQND8BfQy4h16L/mTbHNTrPjL8LnbIzf/hC
   FhGeY9Qx/b/upevNGMybcxQN7ix4jIUIFVTdeE06SO1ABBZ73NYeCZWPT
   vusmS8YRCJv8wqrws1fQX5UMdn+CgFsexKSMku45S57WB9vIzcGUN8Zyt
   g==;
X-CSE-ConnectionGUID: TnYYpwsWSFSSrzLhw47OfQ==
X-CSE-MsgGUID: iVBCcwKTT4ODUUsFA8jcLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2902030"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2902030"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 09:07:23 -0800
X-CSE-ConnectionGUID: oLfO/3DcRY6GArIwDvbrkQ==
X-CSE-MsgGUID: Ec1D3GvdS4eJbv+yodRZRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7354993"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.104])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 09:07:19 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 6 Nov 2026 19:07:16 +0200 (EET)
To: Lukas Wunner <lukas@wunner.de>
cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, 
    Sourabh Jain <sourabhjain@linux.ibm.com>, 
    Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, 
    Alex Deucher <alexander.deucher@amd.com>, 
    Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, 
    Keith Busch <kbusch@kernel.org>, 
    Maciej Grochowski <Maciej.Grochowski@sony.com>, 
    Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH v2 2/2] PCI/AER: Check validity of Error Source ID
 register
In-Reply-To: <357275f9c2554a61bfa6fcbe9a25416cafe9ce00.1793982724.git.lukas@wunner.de>
Message-ID: <93acd5b0-e952-4ecf-d074-8dee5c160792@linux.intel.com>
References: <cover.1793982724.git.lukas@wunner.de> <357275f9c2554a61bfa6fcbe9a25416cafe9ce00.1793982724.git.lukas@wunner.de>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1115972685-1793984836=:2032"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1115972685-1793984836=:2032
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 6 Nov 2026, Lukas Wunner wrote:

> Certain Intel and AMD Root Ports are known to populate the Error Source I=
D
> register with an invalid value.  The AER driver seeks to recognize such
> buggy silicon by assuming invalidity if the bus number is zero.  It then
> searches for the error-signaling device in the hierarchy below the Root
> Port.  This was introduced by commit 28eb27cf0839 ("PCI AER: support
> invalid error source IDs").
>=20
> Alex has provided dmesg output which shows an invalid Error Source ID wit=
h
> a non-zero bus number.  The AER driver's heuristic fails to recognize its
> invalidity:
>=20
>   pcieport 0000:00:07.1: AER: Correctable Error message received from 000=
0:01:00.0 (no details found)
>=20
> The Root Port at 0000:00:07.1 has secondary bus 04, so an error source on
> bus 01 is obviously invalid.  The range of secondary buses is cached and
> checking against it is cheap.
>=20
> Do that instead of relying on a heuristic.  Emit a message when an invali=
d
> Error Source ID is detected to alert silicon validation engineers.
>=20
> If the Error Source ID is the Root Port itself, assume that it is valid.
> This changes behavior if the Error Message originated from a device which
> happens to have the same slot and function number as the Root Port and
> whose bus number was zeroed in the Error Source ID register.  On affected
> Intel and AMD systems, the invalid Error Source ID always has a zero slot
> and function number and there is no Root Port at 0000:00:00.0, so it is
> expected that this change does not lead to false-negatives in practice.
>=20
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D222095
> Tested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux=
=2Eintel.com>
> ---
> Changes versus v1:
>  Reorder a < b && b < c comparisons (Ilpo, Bjorn)
>  Amend kernel-doc of find_source_device() (Sathya)
>  s/subordinate/secondary/ in commit message (Bjorn)
>  Document behavioral change in commit message (sashiko)
> =20
>  drivers/pci/pci.h       |  7 ++++++-
>  drivers/pci/pcie/aer.c  | 35 ++++++++++++++++++++++++++---------
>  drivers/pci/pcie/rcec.c | 14 ++++++++++++++
>  3 files changed, 46 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 77efa4c5c960..aa392bb6a482 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -871,6 +871,9 @@ static inline bool pci_dev_binding_disallowed(struct =
pci_dev *dev)
>   * @id: Value from register PCI_ERR_ROOT_ERR_SRC
>   * @severity: AER severity, 0-UNCOR Non-fatal, 1-UNCOR fatal, 2-COR
>   * @root_ratelimit_print: Flag to log or not log the root's error. 0=3DN=
otLog/1=3DLog
> + * @id_valid: Whether @id is a valid value.  Some Root Ports report an i=
nvalid
> + *=09Error Source ID, necessitating a search for the error-signaling dev=
ice
> + *=09in the hierarchy below the Root Port.
>   * @multi_error_valid: If multiple errors are reported
>   * @first_error: First reported error
>   * @__pad2: Padding for alignment
> @@ -893,7 +896,8 @@ struct aer_err_info {
> =20
>  =09unsigned int severity:2;
>  =09unsigned int root_ratelimit_print:1;
> -=09unsigned int __pad1:4;
> +=09unsigned int __pad1:3;
> +=09unsigned int id_valid:1;
>  =09unsigned int multi_error_valid:1;
> =20
>  =09unsigned int first_error:5;
> @@ -955,6 +959,7 @@ void pcie_link_rcec(struct pci_dev *rcec);
>  void pcie_walk_rcec(struct pci_dev *rcec,
>  =09=09    int (*cb)(struct pci_dev *, void *),
>  =09=09    void *userdata);
> +bool pci_rcec_associated(struct pci_dev *rcec, u16 id);
>  #else
>  static inline void pci_rcec_init(struct pci_dev *dev) { }
>  static inline void pci_rcec_exit(struct pci_dev *dev) { }
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index d492c7ce01e1..6f2460231422 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -951,12 +951,13 @@ static void aer_print_source(struct pci_dev *dev, s=
truct aer_err_info *info,
>  {
>  =09u16 source =3D info->id;
> =20
> -=09pci_info(dev, "%s%s Error message%s from %04x:%02x:%02x.%d%s\n",
> +=09pci_info(dev, "%s%s Error message%s from %04x:%02x:%02x.%d%s%s\n",
>  =09=09 info->multi_error_valid ? "Multiple " : "",
>  =09=09 aer_error_severity_string[info->severity],
>  =09=09 info->multi_error_valid ? "s received, first one" : " received",
>  =09=09 pci_domain_nr(dev->bus), PCI_BUS_NUM(source),
>  =09=09 PCI_SLOT(source), PCI_FUNC(source),
> +=09=09 info->id_valid ? "" : " (invalid source)",
>  =09=09 found ? "" : " (no details found)");
>  }
> =20
> @@ -1146,6 +1147,24 @@ static int add_error_device(struct aer_err_info *e=
_info, struct pci_dev *dev)
>  =09return 0;
>  }
> =20
> +static bool source_id_valid(struct pci_dev *root, u16 id)
> +{
> +=09/* The Root Port or RCEC can itself be a valid Error Source */
> +=09if (pci_dev_id(root) =3D=3D id)
> +=09=09return true;
> +
> +=09/* For RCECs, @id shall be in range of its associated buses/devices *=
/
> +=09if (pci_pcie_type(root) =3D=3D PCI_EXP_TYPE_RC_EC)
> +=09=09return pci_rcec_associated(root, id);
> +
> +=09/* For Root Ports, @id shall be in range of its subordinate buses */
> +=09if (!root->subordinate)
> +=09=09return false;
> +
> +=09return root->subordinate->busn_res.start <=3D PCI_BUS_NUM(id) &&
> +=09       PCI_BUS_NUM(id) <=3D root->subordinate->busn_res.end;
> +}
> +
>  /**
>   * is_error_source - check whether the device is source of reported erro=
r
>   * @dev: pointer to pci_dev to be checked
> @@ -1157,11 +1176,8 @@ static bool is_error_source(struct pci_dev *dev, s=
truct aer_err_info *e_info)
>  =09u32 status, mask;
>  =09u16 reg16;
> =20
> -=09/*
> -=09 * When bus ID is equal to 0, it might be a bad ID
> -=09 * reported by Root Port.
> -=09 */
> -=09if ((PCI_BUS_NUM(e_info->id) !=3D 0) &&
> +=09/* Some Root Ports report an invalid Error Source ID */
> +=09if (e_info->id_valid &&
>  =09    !(dev->bus->bus_flags & PCI_BUS_FLAGS_NO_AERSID)) {
>  =09=09/* Device ID match? */
>  =09=09if (e_info->id =3D=3D pci_dev_id(dev))
> @@ -1174,8 +1190,7 @@ static bool is_error_source(struct pci_dev *dev, st=
ruct aer_err_info *e_info)
> =20
>  =09/*
>  =09 * When either
> -=09 *      1) bus ID is equal to 0. Some ports might lose the bus
> -=09 *              ID of error source id;
> +=09 *      1) Error Source ID register is invalid;
>  =09 *      2) bus flag PCI_BUS_FLAGS_NO_AERSID is set
>  =09 *      3) There are multiple errors and prior ID comparing fails;
>  =09 * We check AER status registers to find possible reporter.
> @@ -1231,7 +1246,7 @@ static int find_device_iter(struct pci_dev *dev, vo=
id *data)
>   * Return: true if found.
>   *
>   * Invoked by DPC when error is detected at the Root Port.
> - * Caller of this function must set id, severity, and multi_error_valid =
of
> + * Callers must set id, id_valid, severity, and multi_error_valid fields=
 of
>   * struct aer_err_info pointed by @e_info properly.  This function must =
fill
>   * e_info->error_dev_num and e_info->dev[], based on the given informati=
on.
>   */
> @@ -1566,6 +1581,8 @@ static void aer_isr_one_error_type(struct pci_dev *=
root,
>  {
>  =09bool found;
> =20
> +=09info->id_valid =3D source_id_valid(root, info->id);
> +
>  =09found =3D find_source_device(root, info);
> =20
>  =09/*
> diff --git a/drivers/pci/pcie/rcec.c b/drivers/pci/pcie/rcec.c
> index 2bf6d9d549ba..88070ef0019c 100644
> --- a/drivers/pci/pcie/rcec.c
> +++ b/drivers/pci/pcie/rcec.c
> @@ -21,6 +21,20 @@ struct walk_rcec_data {
>  =09void *user_data;
>  };
> =20
> +bool pci_rcec_associated(struct pci_dev *rcec, u16 id)
> +{
> +=09if (!rcec->rcec_ea)
> +=09=09return false;
> +
> +=09if (rcec->bus->number =3D=3D PCI_BUS_NUM(id)) {
> +=09=09unsigned long bitmap =3D rcec->rcec_ea->bitmap;
> +=09=09return test_bit(PCI_SLOT(id), &bitmap);
> +=09}
> +
> +=09return rcec->rcec_ea->nextbusn <=3D PCI_BUS_NUM(id) &&
> +=09       PCI_BUS_NUM(id) <=3D rcec->rcec_ea->lastbusn;
> +}
> +
>  static bool rcec_assoc_rciep(struct pci_dev *rcec, struct pci_dev *rciep=
)
>  {
>  =09unsigned long bitmap =3D rcec->rcec_ea->bitmap;
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1115972685-1793984836=:2032--
