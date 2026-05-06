Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A6C239085
	for <linux-pci@vger.kernel.org>; Wed,  6 May 2026 21:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778104134; cv=none; b=LjpLcQUdf632t9lS4JYIxIREbKHCz+vlXsWr3zlI304Iz4Iv9kvQl07qbylCvbKMnYYKwDja/du+HaxDBwubAZTnzaRAuftn3gR97qWXerrZ2q7KP3cj272uUfRSv0RhVItSnZqxhNL9DiwFmOt1B7zCRJ+kRwf6IyxyK0H5aQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778104134; c=relaxed/simple;
	bh=AhmaYTBWAQQH3+qzuPCzCBueUtv9Ti5cwviovFP10Gw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OvKtsZnDV1hEVg8VHNDtEuKdwkR5gq+JlMIaYKR4Q3epOk/aLPvX9jAndoAJwjllnO/PbB4sng4m3e+qUnCJjnocQCicJXfDTIn7Omo4vKWHZWoAIiMgcAHSER34jGleJ368NSjR58FGSQPXiZouudSbqMeTMBRe8H8A1QczUVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZSTSNrr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZSTSNrr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1119C2BCB0;
	Wed,  6 May 2026 21:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778104134;
	bh=AhmaYTBWAQQH3+qzuPCzCBueUtv9Ti5cwviovFP10Gw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=pZSTSNrr11MAiTxKzhfPbV7C4k1Py+TwkktP0NfV+u0keH8tYB67VYaPSMvKHmZkO
	 JJ3Dm2gdYMOgUpS+gjPIYkg9vtw39e664ZyOtYN4efLDe8JJzDurQqmJUvet6v8kwJ
	 M8HAYuHb5qya/18ZsCg+42tPAjURONQDor5dORGVuwD8QZZfgw8WKTJ9nFdo+1MQ5n
	 e9miD7Qey3nu1yQVO8eGQGSI1eQ35x8z23kWTWYS+I1oKBumCMzvprOpjjSZXDxs9a
	 LAxMT1OPdHUnNqAghI+GR0VhGEmpiRjAUJYZcj+N9PmdFimvIcTJ7mUmJm2DAZXY41
	 SENKSobk4AHoQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/8] PCI: aardvark: Add 100 ms delay after link
 training
Reply-To: sashiko@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
In-Reply-To: <20260506152346.166056-7-18255117159@163.com>
References: <20260506152346.166056-7-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 21:48:53 +0000
Message-Id: <20260506214853.D1119C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Bypass of the mandatory 100ms post-reset delay for Gen 1 / Gen 2 e=
ndpoints.
- [Medium] The commit message incorrectly claims that `link_gen` holds the =
negotiated link speed.
--

commit 9114690f6dce7f4f9d92fc0cec16e81c387aa8fb
Author: Hans Zhang <18255117159@163.com>
PCI: aardvark: Add 100 ms delay after link training

This commit adds a 100 ms delay after link training completes for speeds
greater than 5.0 GT/s. It utilizes the pcie_wait_after_link_train() helper
together with the driver's link_gen field to insert the delay once the link
is up.

> The driver already maintains a 'link_gen' field that holds the negotiated
> link speed. Use it together with pcie_wait_after_link_train() to insert
> the required delay immediately after confirming that the link is up.

Is this description of link_gen accurate?

Looking at the driver, pcie->link_gen appears to be populated at probe time
via of_pci_get_max_link_speed() and statically stores the port's maximum
configured link speed capability, rather than being dynamically updated with
the actual negotiated speed.

While passing the maximum capability to pcie_wait_after_link_train() is
correct per the PCIe specification, could the commit message be updated to
reflect the actual contents of the link_gen field?

> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controll=
er/pci-aardvark.c
> index e34bea1ff0ac6..526351c21c49e 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -350,8 +350,10 @@ static int advk_pcie_wait_for_link(struct advk_pcie =
*pcie)
> =20
>  	/* check if the link is up or not */
>  	for (retries =3D 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
> -		if (advk_pcie_link_up(pcie))
> +		if (advk_pcie_link_up(pcie)) {
> +			pcie_wait_after_link_train(pcie->link_gen);
>  			return 0;
> +		}
> =20
>  		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
>  	}

Does this sequence bypass the mandatory 100ms post-reset delay for Gen 1 and
Gen 2 endpoints?

The PCIe specification requires a minimum 100ms delay after a conventional
reset before sending configuration requests. This function is called by
advk_pcie_setup_hw() to fulfill that requirement, but it polls and returns
immediately upon link-up.

If a link trains quickly (e.g., in 10-20ms), the function exits early. Since
pcie_wait_after_link_train() only executes a delay if link_gen > 2:

drivers/pci/pci.h:pcie_wait_after_link_train() {
    if (max_link_speed > 2)
        msleep(PCIE_RESET_CONFIG_WAIT_MS);
}

Are Gen 1 and Gen 2 endpoints left exposed to premature configuration reque=
sts
since the remainder of the mandatory 100ms post-reset delay is skipped?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260506152346.1660=
56-1-18255117159@163.com?part=3D6
