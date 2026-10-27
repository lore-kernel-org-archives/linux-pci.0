Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793118841;
	b=uqoE7fFrhVxxgUcogLJ0iEivhPbBealvzWXu7vBFCTZjo07Vh8avnyxrmpx0+oDHxl1U
	 JcJNT7OGB8DVqMLm22mDyxlmsrv1SAOQ5d4j72KNRO4esGQ9LeGwmZfjNcF3eTLUdKypv
	 AF3vWp4ittE+7PGGrTS5SZiJHLF1wtWFkcLMZNGGzDrs4Lbb6zZ9HRL2cdJUmO6M7cxGg
	 ApgCbwPYXkXBo/QXBS5SWWgljJJzVja8EyyL/eYxUZ6aiNUCV+CjrJ2U2VlSFAcv53t6I
	 PBYvaz5zhEOKc1j6qtHo+vJFTtaPQglc+HllhQyjb/D9lGmcFMbVJq2r5j2P345EvKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118841;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=S0e+2Cj9L2Mwa4D1H9h0I1SlFLKsxVHWHdab6W4WVWM=;
	b=ZCG0Z7Ja6eaIZm8urYQejnKFnBZ87cKG2rNntGmzP1uImDhkn6aorYetuP90l1CJ7+Ej
	 e6qTDFLB3FxwiqNEuwl7/CJ4eG3jMPkF5R22ulUVAfXRduCom1bNn5jDxOfH93n61T0ay
	 jNHNgIXPjB5TQi7TMYmcy7v+xieNylGHHNB6PsF+/SCZ7FLopjFOjvT0aGW1LdOQtr8L6
	 q6ZgBR19w9gtc9eE+metK1BEYS1os+doynf3h2o66U06g2kWXsbeXyAywjZKapyxgat94
	 q1SEgR+np5VwbUdmG4ru2IWbZE0vnHnd8wKHNrbGWuc7RybvRc3UhwB1qDijleqy+Bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kpL4+bRY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5EC606A31E
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 16:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kpL4+bRY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3494F1F031E3;
	Tue, 27 Oct 2026 16:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793118841;
	bh=S0e+2Cj9L2Mwa4D1H9h0I1SlFLKsxVHWHdab6W4WVWM=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=kpL4+bRY3lY9MQ02WWgjlu63vMeAcRTK+RFL3uqfiL+bn1EA/zps3D8Z5duFZ19yY
	 Xxm+wW/aT/uOjZ4YdOZ7oK+ZBI2tsV7JZ4PngSbpjTnatcQLPpqOaoK/TruGqKnNIG
	 S5mDTLFz5cbgXl2ml/QfWk1AU1VYkYWEPqFrxPULRdBJjUy1YLV0o0CjV9txND9lrq
	 CnzrdKCS3a9MPbYLfXzG6m69yThW+ZqgFKqh2UuIYQ5wnT3eWzSH2epH+G3/kUO663
	 pT8EE4/No9gGGPrABSBLHEzqj/MgwhKHY6Iil6g3MqPCIATTynA2YeMlrGDVWTszpK
	 1s421n/2g+wzQ==
Message-ID: <sashiko-outbox-186926@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/13] PCI/IOV: Allow VF drivers to handle resets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lukasz Laguna" <lukasz.laguna@intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261027160446.858300-5-lukasz.laguna@intel.com>
References: <20261027160446.858300-1-lukasz.laguna@intel.com>
 <20261027160446.858300-5-lukasz.laguna@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 16:34:00 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] PCI/IOV: calling VF reset_prepare() before PF breaks hisi_qm PF FLR
--

commit b82e20ef0c7a057bbb242268e11b3dd9218fd7d8
Author: Micha=C5=82 Winiarski <michal.winiarski@intel.com>

PCI/IOV: Allow VF drivers to handle resets

This commit updates PCI function, bus, and slot reset handling to lock
enabled VFs, notify VF drivers via .reset_prepare() and .reset_done(), and
save and restore VF configuration state across PF resets.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index d8e7c7d8e4021..d088302547c34 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c

[ ... ]

> @@ -5171,6 +5202,17 @@ static void pci_dev_save_and_disable(struct pci_de=
v *dev)
>  		return;
> =20
>  	pci_save_state(dev);
> +}
> +
> +static void pci_dev_save_and_disable(struct pci_dev *dev)
> +{
> +	struct pci_dev *vf;
> +
> +	for_each_pci_vf(dev, vf)
> +		pci_dev_reset_prepare_and_save(vf);
> +
> +	pci_dev_reset_prepare_and_save(dev);

[Severity: High]
Does calling .reset_prepare() on each VF before the PF here cause a
self-blocking timeout and reset failure on HiSilicon QM devices
(hisi_hpre, hisi_sec2, hisi_zip, and hisi_acc_vfio_pci) when resetting a PF
with enabled VFs?

In pci_dev_save_and_disable(), pci_dev_reset_prepare_and_save(vf) runs for
every VF and then pci_dev_reset_prepare_and_save(dev) runs for the PF in the
same thread before any .reset_done() callback is invoked in
pci_dev_restore().

When VFs are bound to hisi_acc_vfio_pci (where hisi_acc_vdev->pf_qm points
to the PF's struct hisi_qm), the first VF's .reset_prepare() sets the reset
bit on the shared PF qm->misc_ctl and holds it until .reset_done():

drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c:
hisi_acc_vf_pci_reset_prepare() {
	struct hisi_acc_vf_core_device *hisi_acc_vdev =3D hisi_acc_drvdata(pdev);
	struct hisi_qm *qm =3D hisi_acc_vdev->pf_qm;
	...
	while (test_and_set_bit(QM_RESETTING, &qm->misc_ctl)) {
		msleep(1);
		if (++delay > QM_RESET_WAIT_TIMEOUT) {
			dev_err(dev, "reset prepare failed\n");
			return;
		}
	}
}

Similarly, when VFs are bound to hisi_hpre, hisi_sec2, or hisi_zip on
Kunpeng920, hisi_qm_reset_prepare() -> qm_reset_prepare_ready() acquires the
same bit on pf_qm->misc_ctl via qm_wait_reset_finish(pf_qm) and only clears
it in hisi_qm_reset_done() -> qm_reset_bit_clear():

drivers/crypto/hisilicon/qm.c:
qm_reset_prepare_ready() {
	struct pci_dev *pdev =3D qm->pdev;
	struct hisi_qm *pf_qm =3D pci_get_drvdata(pci_physfn(pdev));

	if (qm->ver < QM_HW_V3)
		return qm_wait_reset_finish(pf_qm);

	return qm_wait_reset_finish(qm);
}

Because the first VF's .reset_done() has not run yet, every subsequent VF's
.reset_prepare() and the PF's own hisi_qm_reset_prepare() will spin waiting
for that bit on pf_qm->misc_ctl until the timeout expires, log an error, and
return early without stopping the remaining VFs or the PF prior to the
hardware reset.

On Kunpeng930 (where qm->ver >=3D QM_HW_V3) with host-bound VFs, each VF's
hisi_qm_reset_prepare() sets the bit on its own vf_qm->misc_ctl. When the PF
subsequently runs hisi_qm_reset_prepare(), it notifies VFs via mailbox and
waits for them:

drivers/crypto/hisilicon/qm.c:
hisi_qm_reset_prepare()
  -> qm_try_stop_vfs()
       -> qm_ping_all_vfs()
       -> qm_wait_vf_prepare_finish()

Each VF's mailbox work handler (qm_pf_reset_vf_process() ->
qm_pf_reset_vf_prepare() -> qm_reset_prepare_ready(vf_qm)) then tries to
acquire the bit on vf_qm->misc_ctl that is already held by that VF's own
.reset_prepare(), timing out and causing the PF reset preparation to fail as
well.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027160446.8583=
00-1-lukasz.laguna@intel.com?part=3D4
