Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA9963DB35;
	Mon, 19 Oct 2026 14:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792418768; cv=none; b=EPZIBD/C5MNyXUF3qYXuse6W6ZF1kraDRCi7DP9m79ICsZ49h2v7ZdIaxv5qRYvsvW+pOoHN3mTHEIGPCfW4VSiE8JmA1ZxViOKLqZ7iJUDKEHXo1Iu7LHTuNWL8ddtCyhGvKLzR5B6cPmAujlHAufjLA8GlX7JKu3Pj3RyU/+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792418768; c=relaxed/simple;
	bh=T1X8NyMjLrM6lwbTS/tavJwPeohEEjXuV1H4Zwrbi6c=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=KnlCsYht7QH06bnA8yMwN/4W0qQNgfsixspcbTSOPOQPzUiQ3j7UaAUAr1Tk4HGKrKWflLxo+hfEqS/zML7wKAOXKdBBFbrtQC7BlJq1WVRNvp4T049Fc+O/KytfQcUnKehbPcBI1PGUj07Pr6VlrPfYQEgv3YhsvLj1H/gntwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqkm2ffx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqkm2ffx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 420D61F000C7;
	Mon, 19 Oct 2026 14:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792418766;
	bh=W1KF1T54tbi68mlMOUPyj9EQFC+4gYgrWKKprB1/NsU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hqkm2ffxdX54FYL++lOVlKYr5QfScIfccPioO+z58diysmxkpT/avpc6HgHBPVaWh
	 mFd5NZMiFQwI7qFeM+dFDVeukgR3z36Kd48SoxnOUbjgnnwAh66Tx+zap9aB6V01xC
	 392r9efTNyz5QL903LCPjfYVhqQjNubsvCzEDaA9nlg3b5piz/KbZfqsrfnNBSbgDK
	 EQeq6iI+MZDx8M52/Wsn0os3D4MHOiDTCkcDF4142WMfzmgltLjmwohDrWNoG1NGB/
	 nAF4JeNjyJsrIhn1eBh+5QgJvnE8wHWhmOYXFwEpPkWjbtl4ohwLxZx49VoZAUK+W9
	 QAkNicK1V9/pA==
Message-ID: <sashiko-outbox-177285@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] thunderbolt: Call SXFP() on Apple systems with Alpine
 Ridge when suspending
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RnJhbmNpc2NvIEJlbHRyw6FuIE1pbGxhbMOpbg==?= <fbeltranmillalen@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261019134851.7496-1-fbeltranmillalen@gmail.com>
References: <20261019134851.7496-1-fbeltranmillalen@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 14:06:05 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] thunderbolt: acpi: tb_acpi_apple_sxfp() in suspend_late breaks noi=
rq suspend
--

commit bf9ec70ca8c7c6c95ce1947e1918dbc5496d5f29
Author: Francisco Beltr=C3=A1n Millal=C3=A9n <fbeltranmillalen@gmail.com>

thunderbolt: Call SXFP() on Apple systems with Alpine Ridge when suspending

This commit adds a suspend_late callback for the software connection
manager that clears bit 26 of plug events CS_20 and evaluates the SXFP(0)
ACPI method under the NHI on Apple systems with Alpine Ridge controllers
when suspending to RAM.

> diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
> index 4e5d0578fd4bc..f12db9d8bf543 100644
> --- a/drivers/thunderbolt/tb.c
> +++ b/drivers/thunderbolt/tb.c
> @@ -3120,6 +3120,12 @@ static int tb_suspend_noirq(struct tb *tb)
>  	return 0;
>  }
> =20
> +static int tb_suspend_late(struct tb *tb)
> +{
> +	tb_acpi_apple_sxfp(tb);
> +	return 0;
> +}

[Severity: High]
Does calling tb_acpi_apple_sxfp() in the suspend_late phase cause
regressions during the subsequent suspend_noirq phase on mainline kernels?

During system suspend, dpm_suspend_late() runs for all devices before
dpm_suspend_noirq() begins. In dpm_suspend(), pci_pm_suspend() resumes the
Alpine Ridge xHCI from runtime suspend and sets pci_dev->state_saved =3D fa=
lse,
while hcd_pci_suspend() -> suspend_common() only disables the PCI device and
defers pci_save_state() to hcd_pci_suspend_noirq().

When nhi_suspend_late() -> tb_domain_suspend_late() -> tb_suspend_late() ->
tb_acpi_apple_sxfp() evaluates SXFP(0) during dpm_suspend_late():

drivers/thunderbolt/acpi.c:tb_acpi_apple_sxfp()
    status =3D acpi_execute_simple_method(sxfp, NULL, 0);

SXFP(0) powers down the controller's xHCI when nothing is connected to that
side. Later, when dpm_suspend_noirq() runs, hcd_pci_suspend_noirq() saves t=
he
PCI configuration space of the now powered-off xHCI:

drivers/usb/core/hcd-pci.c:hcd_pci_suspend_noirq()
    pci_save_state(pci_dev);

In mainline, pci_save_state() unconditionally reads standard PCI config
space and PCIe capability registers:

drivers/pci/pci.c:pci_save_state()
    for (i =3D 0; i < 16; i++) {
        pci_read_config_dword(dev, i * 4, &dev->saved_config_space[i]);
        ...
    }
    dev->state_saved =3D true;

Because the xHCI is already powered down, pci_save_state() records
0xffffffff into saved_config_space[] and the PCIe capability save buffers,
and marks state_saved =3D true. On resume, pci_pm_resume_noirq() ->
pci_pm_default_resume_early() -> pci_restore_state() writes those saved
0xffffffff values back into the xHCI's BARs, command register, and PCIe
capability registers.

Additionally, within drivers/thunderbolt/tb.c, running tb_suspend_late()
before tb_suspend_noirq() means SXFP(0) executes while tcm->hotplug_active
is still true and tb->ctl is still running, before tb_suspend_noirq() has
disconnected DisplayPort resources, exited redrive mode, and called
tb_switch_suspend(tb->root_switch, false):

drivers/thunderbolt/tb.c:tb_suspend_noirq()
    tb_disconnect_and_release_dp(tb);
    tb_switch_exit_redrive(tb->root_switch);
    tb_switch_suspend(tb->root_switch, false);
    tcm->hotplug_active =3D false; /* signal tb_handle_hotplug to quit */

Could evaluating SXFP(0) before tb_suspend_noirq() and hcd_pci_suspend_noir=
q()
corrupt the xHCI PCI state on resume or interfere with tb_switch_suspend()?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019134851.7496=
-1-fbeltranmillalen@gmail.com?part=3D1
