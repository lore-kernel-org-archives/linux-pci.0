Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B343BB689
	for <linux-pci@vger.kernel.org>; Tue,  6 Oct 2026 16:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791304395; cv=none; b=FdoNmLagO6NyTMk+ShsWEW1AE/L5QLDTw2yl3ej+pp1VbOrE2Ejju255LaRg/UFnBMVQWk8WLROos77seyTT/gHI0UgO4j4QvdgiyPHljfJMJv4JEG4AF68E9QzYzjp1GIYa9sx+NBszWtk4en2AQs9UlyldtXK+sKjONV4IuPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791304395; c=relaxed/simple;
	bh=a52Fd4+OEBGLELOUCQA2sgtyrb4rURk/c6M+txAJYC4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=btdpkJVogumx4rsc6Pbkt25B87lVqWyJpnX02F7AUF9q/ePRsSp+OJ+2tECKRytgfAzCNF6o6Q/0mB1VrvbVcnIf5Oa+72WctknDZL22iqzp3jDU5b98kQ+nVoq0ys6sus0uOekh+oSUYmj0Kpm78TcffnIFEwaKMUjQWj7pi00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1kDA4nG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1kDA4nG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E20591F0089B;
	Tue,  6 Oct 2026 16:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791304394;
	bh=G9ZlvAcOw6D2UqUZntJwDCDLu5aPerphe74iEtrluI0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H1kDA4nGl44REMb19nVhDyD9h7NxnT6/rtnk09BMlfxRdypQGsj8ZvGyLSjnaU3ao
	 h4PZZoTJvx/bRURPZpVIgFHVozBKg8aZ+Hqur6yzC9kZPPiZW2O16THvMdRORBcfPv
	 cShnkFFGJHcqRSFbLymdZawpLLiLkCQ0d8xmNgw5XEiAZ3jhqX0e7+afVzKFdeVvSx
	 Uqpj3cTbF3GBwMDwHTJpJSJlGlRZoaV0Ivn5gPKR+wSSfPDsP+rPXudL1JT6SwoBHk
	 J1PvLU/RX4h3d/G6YGsHWTGahpqDZXR5MVoFz/qkS2qGfZzHaB4ZpVqPy/wUDn5lfb
	 YJxoOkrHFvvxg==
Message-ID: <sashiko-outbox-162260@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] selftests/pcie_lmr: Add tests for the Lane
 Margining debugfs interface
Reply-To: sashiko-reviews@lists.linux.dev
To: "Priyank Rathod" <rathodpriyank@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261006-pcie-link-endpoints-v4-2-ad5398c4260c@google.com>
References: <20261006-pcie-link-endpoints-v4-0-ad5398c4260c@google.com>
 <20261006-pcie-link-endpoints-v4-2-ad5398c4260c@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 16:33:13 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests/pcie_lmr: reversed logic skips LNKCTL restoration test
--

commit b1633adf22c71efa783c2272b3fd92aab3e39291
Author: Priyank Rathod <rathodpriyank@google.com>

selftests/pcie_lmr: Add tests for the Lane Margining debugfs interface

Adds a KTAP test for the Lane Margining at the Receiver debugfs interface.
It runs default passive checks on every pcie_lmr_* directory, and active
margining sessions if PCIE_LMR_DEV points to a port.

> diff --git a/tools/testing/selftests/pcie_lmr/pcie_lmr.sh b/tools/testing=
/selftests/pcie_lmr/pcie_lmr.sh
> new file mode 100755
> index 0000000000000..99070d221ae06
> --- /dev/null
> +++ b/tools/testing/selftests/pcie_lmr/pcie_lmr.sh

[ ... ]

> +active_tests()
> +{

[ ... ]

> +	if check_end_session "$d"; then
> +		ktap_test_pass "$dev: end the session"
> +		ACTIVE_DIR=3D
> +	else
> +		ktap_test_fail "$dev: end the session"
> +	fi
> +
> +	up=3D$([ "$rx" =3D 6 ] && echo "$dev" || echo "$partner")
> +	after=3D"$(link_regs "$dev") $(link_regs "$partner")"
> +	if [ -z "${before// }" ]; then
> +		ktap_test_skip "$dev: setpci not found"
> +	elif [ -n "$up" ] && [ ! -d "/sys/bus/pci/devices/$up/link" ]; then
> +		ktap_test_skip "$dev: no OS ASPM control on link"

[Severity: Medium]
Is it possible that the logic for identifying the upstream port is reversed?

In active_tests(), the variable up is assigned using the receiver type.
If rx=3D6, dev is the Endpoint device, so up becomes the Endpoint.
If rx=3D1, dev is the Downstream Port, meaning partner is the Endpoint,
so up still evaluates to the Endpoint device.

Because up always evaluates to the Endpoint device instead of the
Downstream Port, the check for the sysfs link directory will always fail,
as that directory is only present on the Downstream Port. Will this cause
the test to unconditionally skip the final LNKCTL restoration checks?

> +	else
> +		check "$dev: LNKCTL and LNKCTL2 restored on both ends" \
> +			test "$before" =3D "$after"
> +	fi
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006-pcie-link-=
endpoints-v4-0-ad5398c4260c@google.com?part=3D2
