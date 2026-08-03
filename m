Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C2A2E739C;
	Mon,  3 Aug 2026 18:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785781704; cv=none; b=DbnMG21qmfXiCpSzAviBk9AuHiUJMjjhDypUecUON6+lzcG3w8dNaj0Bh9AA2xu4as7SSjlnB473e9z7kdCId4ystxYHQ6SIBBdSIxPbQZ+q31LvbrVycQgh6W6Y+3Wq098smon5w2seWMGGdT3S7Il8VsbxiVYzKoy7YLqjRxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785781704; c=relaxed/simple;
	bh=k7r2BAdeE4vQMj32cYEVlYRLaZL9NgOQVz2HmiQdfkQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eyi+6JVIT80+Xbhdgtw1P6INcGg+TqB2xi39Ag5S20kr2TlRStlkWbPsAcaBQKFvfrlgfMgVNXKZg6zdw0YqXygKKrx67WaAFIW4eEYn4+B0ZTOsxTnjvXrNQT7+EazMk2o0hwXTCMC5OhmnqTgwUmbOWI19CZQXBv3ht39DFCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OX98n0yk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OX98n0yk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56AA11F000E9;
	Mon,  3 Aug 2026 18:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785781702;
	bh=ZU2vcfHbavmVGPVbziwkN9ZACfXvsqkaohFlU+YKhOI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OX98n0yk+12CAd8GZaHq/QLKQ1GBx43TnmDWOpk8YnLT5XkH11WxWkRA6eoabdpTG
	 NAZrarJ9Ity1KQnAlTJ6Gg09ciIG88o1SiMirqO/MQXQFiDPRy0Xaw19rQ1xTwsCSp
	 Jg+IXpmo/AZfki1egCHejDSc5jDQ4WzpCbqtXWB2jBSqYjtig7eu8AtoouK4Wfd4p4
	 w3XngUO8UJZPzjVHiOj/CLq0P1jWMI4rrPunti+D3G9kLkyZbRJvycFPGx//GsPLTk
	 WNKTaome30/Frzfrt1LsZiGeMw54wZqpZMh0qN4zq97hHwl+aTfwmRmg4NmRSr8XVD
	 KFayqODueszeg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/11] PCI: endpoint: pci-epf-vntb: Add outbound MW
 group commands
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org
In-Reply-To: <20260803180439.1963864-7-den@valinux.co.jp>
References: <20260803180439.1963864-1-den@valinux.co.jp>
 <20260803180439.1963864-7-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 18:28:21 +0000
Message-Id: <20260803182822.56AA11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] The cleanup path `epf_ntb_mw_bar_clear()` unconditionally calls `e=
pf_ntb_teardown_mw_group(ntb, 0)` for packed MWs, leading to unmapping of p=
hysical address 0 if initialization fails.
- [High] The automatic ATU mapping teardown silently fails when `packed_mws=
 =3D=3D 1`, leading to ATU resource leaks and stale memory mappings.

Pre-existing issues:
- [High] Failure to unmap outbound ATU mappings for singleton (non-packed) =
memory windows during driver unbind or error cleanup leaves stale DMA trans=
lations active.
- [High] The command handler `epf_ntb_cmd_handler` reads `ctrl->command` an=
d then `ctrl->argument` without a read memory barrier, risking processing o=
f stale arguments.
--

--- Patch [6]: [PATCH 06/11] PCI: endpoint: pci-epf-vntb: Add outbound MW g=
roup commands ---
commit 6b0d64af683bb36f33f200f34cffed00c1c6d648
Author: Koichiro Den <den@valinux.co.jp>

PCI: endpoint: pci-epf-vntb: Add outbound MW group commands

Packed logical MWs share one contiguous EPC address range. Their
outbound translations can therefore use one mapping as well.

Add commands to map or unmap a complete group in one operation. Keep the
existing commands for singleton MWs.

> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/=
endpoint/functions/pci-epf-vntb.c
> index aa8d304fe861f..526cc31d94351 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
[ ... ]
> @@ -319,6 +321,50 @@ static int epf_ntb_teardown_mw(struct epf_ntb *ntb, =
u32 mw)
[ ... ]
> +static int epf_ntb_teardown_mw_group(struct epf_ntb *ntb, u32 mw)
> +{
> +	unsigned int first, count;
> +	int ret;
> +
> +	ret =3D epf_ntb_get_mw_group(ntb, mw, &first, &count);
> +	if (ret)
> +		return ret;
> +	if (count <=3D 1)
> +		return -EOPNOTSUPP;

[Severity: High]
Does returning -EOPNOTSUPP here cause an ATU resource leak when a single
packed memory window is configured?

When packed_mws =3D=3D 1, this returns -EOPNOTSUPP, which is then silently =
ignored
by callers like epf_ntb_mw_bar_clear() and COMMAND_LINK_DOWN.

This leaves the ATU hardware mappings active while the underlying physical =
EPC
memory is freed, which could lead to memory corruption if the physical addr=
ess
is reallocated.

> +	if (mw !=3D first)
> +		return -EINVAL;
> +
> +	pci_epc_unmap_addr(ntb->epf->epc, ntb->epf->func_no,
> +			   ntb->epf->vfunc_no, ntb->vpci_mw_phy[first]);
> +
> +	return 0;
> +}
[ ... ]
> @@ -378,6 +424,14 @@ static void epf_ntb_cmd_handler(struct work_struct *=
work)

[Severity: High]
This is a pre-existing issue, but does epf_ntb_cmd_handler() risk processing
stale arguments due to missing memory barriers?

The handler reads ctrl->command, checks it, and then reads ctrl->argument f=
rom
DMA-coherent memory.

Without a read memory barrier (e.g., smp_rmb()), control dependencies do not
prevent speculative reads on architectures with weak memory ordering.

Could the CPU speculatively read a stale argument before the command is ful=
ly
resolved?

>  		ret =3D epf_ntb_teardown_mw(ntb, argument);
>  		ctrl->command_status =3D ret ? COMMAND_STATUS_ERROR : COMMAND_STATUS_O=
K;
>  		break;
[ ... ]
> @@ -976,6 +1032,9 @@ static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb=
, int num_mws)
>  	unsigned int count;
>  	int i;
> =20
> +	if (ntb->packed_mws)
> +		epf_ntb_teardown_mw_group(ntb, 0);
> +

[Severity: High]
Is it possible to unmap physical address 0 if initialization fails?

If pci_epc_set_bar() fails for i=3D0 during epf_ntb_mw_bar_init(), it branc=
hes
to the error path and calls epf_ntb_mw_bar_clear(ntb, 0).

Because ntb->packed_mws is true, it unconditionally calls
epf_ntb_teardown_mw_group(ntb, 0).

Since the memory allocation was never reached for i=3D0, ntb->vpci_mw_phy[0=
] is
still 0, causing pci_epc_unmap_addr() to operate on uninitialized physical
address 0.

>  	for (i =3D 0; i < num_mws; i++) {
>  		barno =3D ntb->mw_layout[i].barno;

[Severity: High]
This is a pre-existing issue, but does this loop fail to unmap outbound ATU
mappings for standard (non-packed) memory windows?

During driver unbind or error cleanup, this loop frees the outbound EPC mem=
ory,
but it lacks a call to pci_epc_unmap_addr() for unpacked memory windows.

The physical EPC memory is freed while the ATU mapping remains active in
hardware, which could lead to silent memory corruption if re-allocated to
another endpoint function.

>  		if (!bar_cleared[barno]) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803180439.1963=
864-1-den@valinux.co.jp?part=3D6
