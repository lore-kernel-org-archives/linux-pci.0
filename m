Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904EB23BCF7
	for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 02:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779070157; cv=none; b=UNVGQAPNnsNlmlkYAprj0w2ZvnSt4lYEd1UK8iFCKG93JJq9dVaKSBpsTXWJdZrLfAFC6dw52qaXmqje0HJW+AxvSZ+yd7zLM5L2W5i3DGarwYuxg28W+f8bjYxD3Ygp4zteJJdec2brA/CG1sVJNJSlLnfOJLwjXpy7D5Z2ueA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779070157; c=relaxed/simple;
	bh=cgq5r4DfjneL8vcci1DHI9z2/+LFQrBo7P7mWbFxBQE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ShDtFBOw22AZlf6srbUfWPF/qPxX6pIc+Q6pEa//SzYJntSb8irS4TpQI8n19fS9IjPOCV5Fu8xSdO71SIHPwjjoFe5iPjzJVAfATcIMTSjbhTCsT9NgXryA5qBRnbjqMzHBzF3Xf8To9NdIpcrn+PSzx9cwlbqtoFTONQRBKAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWExv4Rw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWExv4Rw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1850FC2BCB0;
	Mon, 18 May 2026 02:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779070157;
	bh=cgq5r4DfjneL8vcci1DHI9z2/+LFQrBo7P7mWbFxBQE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=MWExv4RwL2vwIMcXF7Hqxy+6QotNqyFycYU/0gcJWztiTPh+AtSUbHmTnc+TqORG1
	 bqqPfIuw0R0MfDrLfBG2us+9npHOtaRMSEVKHn0IXMZParFG8ZGPgsdhmCW9FzRzT+
	 kj5bABEz7BgKejp0ypTP17SlqiTlJjc3ZHSTsWrXbZ79x3Vme/0FC3D6Hxn7fvePbo
	 a7OcS54AJRhzhb9D6EZ5iOCzg6dsP7D7sht7HTOOmGUkNmD0zFQ0+57DSOxcKj/CFu
	 SCZ7F8E8NS77E/Ty9Q4K8bWZoX2I8Qf4SccLyY8ph0qMzsy0JXTzE/Gp+TtznN3eEd
	 QBbhXkNf5WZRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/7] PCI: aardvark: Add 100 ms delay after link
 training
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
In-Reply-To: <20260518004246.1384532-6-18255117159@163.com>
References: <20260518004246.1384532-6-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 02:09:16 +0000
Message-Id: <20260518020917.1850FC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Failure to enforce the mandatory 100ms post-reset delay for Gen 1 =
and Gen 2 devices.
- [Medium] Commit message incorrectly claims that `link_gen` holds the "neg=
otiated link speed".
--

commit 82256a299ecbac6749b1ecf25bbecc74415b47f2
Author: Hans Zhang <18255117159@163.com>

PCI: aardvark: Add 100 ms delay after link training

This commit introduces a mandatory 100ms delay after link training completes
for Aardvark PCIe controllers operating at speeds greater than 5.0 GT/s. It
utilizes pci_host_common_link_train_delay() along with the existing link_gen
field to insert this delay once the link is confirmed up.

> The driver already maintains a 'link_gen' field that holds the negotiated
> link speed. Use it together with pci_host_common_link_train_delay() to

This isn't a bug, but does link_gen actually hold the negotiated link speed?

Looking at advk_pcie_probe(), pcie->link_gen is populated using
of_pci_get_max_link_speed(), which reads the static max-link-speed
capability from the device tree rather than the dynamically negotiated spee=
d.

While passing this static capability correctly implements the PCIe spec,
could the commit message be updated to accurately describe the variable's
contents?

> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controll=
er/pci-aardvark.c
> index e34bea1ff0ac6..fd9c7d53e8a78 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c

[ ... ]

> @@ -350,8 +351,10 @@ static int advk_pcie_wait_for_link(struct advk_pcie =
*pcie)
> =20
>  	/* check if the link is up or not */
>  	for (retries =3D 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
> -		if (advk_pcie_link_up(pcie))
> +		if (advk_pcie_link_up(pcie)) {
> +			pci_host_common_link_train_delay(pcie->link_gen);
>  			return 0;
> +		}
> =20
>  		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
>  	}

Does this code enforce the mandatory 100ms post-reset delay for Gen 1 and
Gen 2 devices?

While this issue wasn't introduced by this patch, the existing code
fundamentally violates the PCIe Base Specification. The spec requires a
minimum 100ms delay after Conventional Reset (PERST# deassertion) before
sending Configuration Requests for ports supporting <=3D 5.0 GT/s.

In advk_pcie_setup_hw(), after PERST# is deasserted, the code calls
advk_pcie_wait_for_link(). If a Gen 1 or Gen 2 device trains quickly, the
new pci_host_common_link_train_delay() adds no delay, and the function
returns immediately.

Consequently, the PCI core will proceed to pci_host_probe() and start
issuing Configuration Requests before the 100ms minimum window has elapsed.
Can this cause Gen 1 or Gen 2 devices to fail to enumerate?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518004246.1384=
532-1-18255117159@163.com?part=3D5
