Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793709604;
	b=kxAcyRpkqhpvKLQsBTUlbbc609vFLz8vTx54TJAVJOtBYC0h4XZUb/V8uEYKnLGtYd0v
	 1P3KvL9e9tB/JEINKGxqIr+kmOvOaw5va+nXSnEWi5J/M369bWZjGgnHo3F+lqHoOqLdL
	 xD+cqmrW7ou8GrdxJhf5LyJYDf2bAzBzxJ4UhOKbcX2p3c7IXobyIk9bpjeIiAUDJnGQ1
	 RQ+qhCRddzuWhG5VW/Scabs6Hurr0Z0Yq26m5N20wlb1bGJ12LfWf9wHlUHb6iFjKGYIo
	 JCVafsUVHLMBUROU8lR4V+tiwLlsygpOQYQYPzIxs5xf0r7xn+EYABiybyj0m+eollw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793709604;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=kNMbnPFcyJK77TPDd1xGOQdAATjK7eqRZWunEZL/ni0=;
	b=bj8OPlXlKm08vqqNZtWnKwnnaClgGO2KsYqGW3lB49JbeaqIpk1PPh5+TpOufIZB/NNi
	 rqaDQZ7tqDQ8SHotIs0WVcSh97w2QXVb2DrRKFXtvp3eztJoRQdhzizGbpO77u30JW6eF
	 EBn90uGiOELmZVrxrJGM1hC47a/b9C3zqT+LkrZBdHvq5e2gdZXII9USOfaJxhygVjFFO
	 Ury3YzawYttsL7bBaaUoswhNBONjP+pzO7KJWnal7TGlQLb427ii3KIoeSxVEH826IW0i
	 VRs3/yWMo/lqE/v16RbiuzCYQxmp0jjqA9sNfmiFXKyRPRtzmfK0I54AQtdRs6AFZWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=oJ4tXrrK;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC53606A324
	for <linux-pci@vger.kernel.org>; Tue,  3 Nov 2026 12:40:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DC53606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=oJ4tXrrK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793709603; x=1825245603;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=XCiKLwinV99WNnDVV2Sect+DLYC+kykjSYXDYWEmi0s=;
  b=oJ4tXrrKOO0Fzqy55FJZlg9+op1yrwt2YasfUU+rU1Rs0wqfH03eW0d7
   VEHOecMuITEMblluGXBllD/HcjXz32+pYqXHCAkz1RMeU3xmdye5OKlFt
   ig81aGigecd2DrFZQNkYex1u6bekMVM4yhHE/hWbeCUfpMJ4GNoXK4bsG
   kW4PoOIizshvVjKDPYnOJoHxqxn6LIPlQKf/+8fV1bvZjyz+EUaAtlD27
   kKobEQ6ljrQq3GaRME4swg7l5qqFdyiNdOrafdsddTvpY4ZWD9940KdL8
   y39g0gG3F0YsqaLuiaf+6v4gWt2xT0Qg6JwVa5QULzPYWs2rDSYt50kpI
   A==;
X-CSE-ConnectionGUID: LhuTAojVQYa3Tvr14rdIfA==
X-CSE-MsgGUID: bm0oHAtHR4qPXKKyPsVNHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2311446"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2311446"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 04:40:03 -0800
X-CSE-ConnectionGUID: cyacEPFhQBuDb0dqgLmxcg==
X-CSE-MsgGUID: X3JjSi4fToyNNKZdyldFTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6742790"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.179])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 04:40:00 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 3 Nov 2026 14:39:55 +0200 (EET)
To: Lukas Wunner <lukas@wunner.de>
cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, 
    Sourabh Jain <sourabhjain@linux.ibm.com>, 
    Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, 
    Alex Deucher <alexander.deucher@amd.com>, 
    Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, 
    Keith Busch <kbusch@kernel.org>, 
    Maciej Grochowski <Maciej.Grochowski@sony.com>
Subject: Re: [PATCH 1/2] PCI/AER: Avoid NULL pointer deref on search for
 Error Source
In-Reply-To: <6de42407246d270c75126baa338761e6f21ab067.1793697480.git.lukas@wunner.de>
Message-ID: <cb623055-e0fd-1d3f-7944-ed20971f6b7b@linux.intel.com>
References: <cover.1793697480.git.lukas@wunner.de> <6de42407246d270c75126baa338761e6f21ab067.1793697480.git.lukas@wunner.de>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-699220464-1793709595=:1105"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-699220464-1793709595=:1105
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 3 Nov 2026, Lukas Wunner wrote:

> A Root Port's subordinate bus may be NULL if the PCI core runs out of bus
> numbers on enumeration.  Yet when the AER driver searches for the source
> of an Error Message, it dereferences the subordinate pointer without
> checking for NULL.  Fix it.
>=20
> Fixes: 28eb27cf0839 ("PCI AER: support invalid error source IDs")
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v2.6.31+
> ---
>  drivers/pci/pcie/aer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index db4f607f889c..d492c7ce01e1 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1251,7 +1251,7 @@ static bool find_source_device(struct pci_dev *pare=
nt,
> =20
>  =09if (pci_pcie_type(parent) =3D=3D PCI_EXP_TYPE_RC_EC)
>  =09=09pcie_walk_rcec(parent, find_device_iter, e_info);
> -=09else
> +=09else if (parent->subordinate)
>  =09=09pci_walk_bus(parent->subordinate, find_device_iter, e_info);
> =20
>  =09if (!e_info->error_dev_num)
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-699220464-1793709595=:1105--
