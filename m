Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771B43A783D;
	Thu, 22 Jan 2026 05:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769061382; cv=none; b=IPdrX9onowQcXvFyy4dYYdMAxgb6m1Q3QwLxnW80L4f1KENBceeszdlK482vIzS9LS5csAytyuEpKMYUEowi3gSHGhN2iUxGBjLhz9qI9YANrWp9dz2bfIt7FJu3HmO/Tw2sE9pLFVJVoiTgxPZPBeMCd05JECAcDxbZewW4buw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769061382; c=relaxed/simple;
	bh=dctgQsMiAb7htjNtefoGoI4TCxrhGixIN9VUP5hTj+U=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=drfZiOw9NKXueOpspo2mKGqw+IOYAu/bUHCR2WT8Pjka5VE14UGtkN8FPNSODmrlmVjjIa620ogHAgyA2hGvACKhSpRpR3UUUCENHSe/Igdh44CYmj+WDHzLBfg6PH2zRsJlOGix3D8Tbhaj4gKrPGZuNS3Fl+/fSjvbEodNv+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QhM0cD6H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QhM0cD6H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 832F0C116C6;
	Thu, 22 Jan 2026 05:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769061382;
	bh=dctgQsMiAb7htjNtefoGoI4TCxrhGixIN9VUP5hTj+U=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=QhM0cD6HgKClNHml4aEpDT5g5EqNtKwqj64foMomUE2tiVSUIbYCH1nFiYynOLfWt
	 r9MM4jqBvn6DATbd90ClWOns7qGp5wje/xMvlKgdJhV6LJ7VjObMOSgctLZwne1mqO
	 bywtggOi8ri0TD9pJtxWQUCPiuXfr39BfKe+jD3Nq2A5ssrA8gasKKJSPEkPqHsLbf
	 8c15RpLNX+mdN9PfmEfXFDybEhagoOl+qeGDcsb6f+UoId9Pf/WLofCcArV5mXtC0l
	 Po8uZ14Xg3dY0CzEQJIC8mhTuhppTYLZdT5/HGM3tA7TZU3SfuFqMrZV0aV1utqovm
	 c1+wOeikFXD/Q==
Date: Thu, 22 Jan 2026 06:56:21 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Aksh Garg <a-garg7@ti.com>
CC: linux-pci@vger.kernel.org, jingoohan1@gmail.com, mani@kernel.org,
 lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
 bhelgaas@google.com, linux-kernel@vger.kernel.org, s-vadapalli@ti.com,
 danishanwar@ti.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_1/2=5D_PCI=3A_dwc=3A_ep=3A_Fix_resizab?=
 =?US-ASCII?Q?le_BAR_support_for_multi-PF_configurations?=
User-Agent: Thunderbird for Android
In-Reply-To: <5f83a07a-ef35-47e9-b40f-fc7617a4488c@ti.com>
References: <20260121054214.274429-1-a-garg7@ti.com> <20260121054214.274429-2-a-garg7@ti.com> <aXCjP8KZw1ig8i-W@ryzen> <5f83a07a-ef35-47e9-b40f-fc7617a4488c@ti.com>
Message-ID: <F757BE07-47EB-49B0-BEA6-03ED01C4497C@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 22 January 2026 06:05:47 CET, Aksh Garg <a-garg7@ti=2Ecom> wrote:
>>> --=20
>>> 2=2E34=2E1
>>>=20
>>=20
>>=20
>> Thank you for fixing this!
>>=20
>> Reviewed-by: Niklas Cassel <cassel@kernel=2Eorg>
>>=20
>>=20
>> You do need another patch in this series though, that fixes:
>> https://github=2Ecom/torvalds/linux/blob/v6=2E19-rc6/drivers/pci/contro=
ller/dwc/pcie-designware-ep=2Ec#L972-L986
>>=20
>> As currently, ptm_cap_base is fetched using dw_pcie_find_ext_capability=
()
>> instead of your new dw_pcie_ep_find_ext_capability() which takes a func=
_no=2E
>>=20
>
>I examined the register spaces across different PFs to check whether all =
the PFs have the PTM capability registers, and confirmed that PTM capabilit=
y registers exist only in PF0=2E PCIe r6=2E0 section 7=2E9=2E15 'Precision =
Time Management Extended Capability (PTM Capability)' states that " For End=
points and Switch Upstream Ports that support PTM, this Capability is requi=
red in exactly one Function of the Upstream Port and that Capability contro=
ls the PTM behavior of all PTM capable Functions associated with that Upstr=
eam Port"=2E This indicates that PTM capabilities are controller-level regi=
sters rather than per-function registers=2E Hence, in my opinion, ptm_cap_b=
ase does not require modification, since dw_pcie_find_ext_capability() and =
dw_pcie_*_dbi() already correctly access PF0's register space, which is the=
 expected behavior for controller-level PTM management=2E


Hello Aksh,

Thanks a lot for digging in to this=2E

Since commit:
https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/pci/pci=2Egit/commit/?=
h=3Dcontroller/dwc&id=3D86291f774fe8524178446cb2c792939640b4970c

Together with your patch,
there will only be a single call site in pcie-designware-ep=2Ec that uses =
dw_pcie_*_dbi() instead of dw_pcie_ep_*_dbi() remaining=2E

Thus, I think we should at least add a comment explain why this is the onl=
y place in the whole file that can ignore func_no=2E


Kind regards,
Niklas
