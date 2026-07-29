Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A334BC030
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 13:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785332644; cv=none; b=V/J4b9aSEEQqdBol96RuVdOF7BY9JZJT/CnD1KwfhNatvsWjkLQN1436gfUrIOYlXe1ASvx4reqmljgH8BIzvjeXkq1CDUXRwY/bbfnu2XhgXhbS79w3qtMnhUOVy/fephsKaHVAsSpAcEodJP2YaQHaCHXBofZAg6TjOssAMYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785332644; c=relaxed/simple;
	bh=zr9JbGWtDAK3hyv6bswWAws2n8LzMCTShfkfRvWObQo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U5kebc9Mv3E+WUROvYQ5teJgJUIAhL051gTVM2cL+kN2N2N9vUCn1LE7OmDvWj30lpXzxQ5HIcnAU8/Ryn6NtYrXyhwIh4Obqab0QsHa2WBqWF4D281mrNF6Cd9jQ2S8YL9XKpUuCn1evNB+8Y1UUsPsoMtwaT1jn1if8h1B6sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dRoAyXVO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRoAyXVO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EAD31F00A3A;
	Wed, 29 Jul 2026 13:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785332641;
	bh=v727F5Sq1RRseRdj9Ys3C8jZc36DyYObJoshfEus2Xs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dRoAyXVOnQSzIycwCOspECW2fTuIjISWJhQw4/87sKyvYQyDt6bcdgRd1JCH6XMQT
	 yzjaC3BIeP3ypJiudKY4NMCKaIUvS4TkvDbotpHkwKxARK2bxVj1dLWsrUpD1MafRc
	 s+gQ6yGnYcNGkZv4sClsd7TiICignZlB35cwNKrlqUppulM8/Ul6gphwbdvXOrS17q
	 o8x2bpYq+NCDQHsvNprbljnYqMnIG2A7in8du6pFohmUyt/f/7QrJU/kn3sn1/wJre
	 8uUpBpyogavRa4QPUaFtAucydwJsGNitAFhhMv6Sh7wRsvcjzXJVy2GTYt5tnhIaZb
	 QZ/gmyhXwBmgw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] PCI/pwrctrl: tc9563: use devm-managed I2C dummy
 device allocation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lorenzo Bianconi" <lorenzo.bianconi@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260729-pci-pwrctrl-tc956x-regmap-v1-2-20ce61a3ce12@oss.qualcomm.com>
References: <20260729-pci-pwrctrl-tc956x-regmap-v1-0-20ce61a3ce12@oss.qualcomm.com>
 <20260729-pci-pwrctrl-tc956x-regmap-v1-2-20ce61a3ce12@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 13:44:01 +0000
Message-Id: <20260729134401.8EAD31F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Use-After-Free due to teardown order inversion between i2c_put_ada=
pter() and devm-managed dummy client release.
--

--- Patch [2]: [PATCH 2/2] PCI/pwrctrl: tc9563: use devm-managed I2C dummy =
device allocation ---
commit f54ecfd3f2485cf33e559cd8f58fa24de337138b
Author: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

PCI/pwrctrl: tc9563: use devm-managed I2C dummy device allocation

This patch converts the driver to use devm_i2c_new_dummy_device to manage
the I2C dummy client. It removes the manual i2c_unregister_device calls
from the probe error path and the remove function.

> diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwrct=
rl/pci-pwrctrl-tc9563.c
> index 8bccf3abd1892..5b05e76f6c80d 100644
> --- a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> +++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
[ ... ]
> @@ -607,7 +606,6 @@ static int tc9563_pwrctrl_probe(struct platform_devic=
e *pdev)
>  power_off:
>  	tc9563_pwrctrl_power_off(&tc9563->pwrctrl);
>  remove_i2c:
> -	i2c_unregister_device(tc9563->client);
>  	i2c_put_adapter(tc9563->adapter);
>  	return ret;
>  }

[Severity: High]
Will this cause a use-after-free by changing the teardown order?

By switching to devm_i2c_new_dummy_device, the dummy client is now
unregistered by devres cleanup, which executes after tc9563_pwrctrl_probe
returns.=20

Because i2c_put_adapter is still called manually before returning, the
adapter reference is dropped before devres unregisters the dummy client. If
dropping this reference allows the adapter to be freed concurrently, it wou=
ld
forcibly unregister all children. When devres later attempts to unregister
the client, it would operate on an already-freed pointer.

Could devm_add_action_or_reset be used to manage the i2c_put_adapter call
so the teardown sequence happens in the correct reverse order?

[ ... ]
> @@ -619,7 +617,6 @@ static void tc9563_pwrctrl_remove(struct platform_dev=
ice *pdev)
>  					struct tc9563_pwrctrl, pwrctrl);
> =20
>  	tc9563_pwrctrl_power_off(&tc9563->pwrctrl);
> -	i2c_unregister_device(tc9563->client);
>  	i2c_put_adapter(tc9563->adapter);
>  }

[Severity: High]
Does this also expose driver unbind to the same teardown order inversion?

Since tc9563_pwrctrl_remove executes before devres cleanup, dropping the
adapter reference here deterministically happens before the dummy client is
unregistered.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729-pci-pwrctr=
l-tc956x-regmap-v1-0-20ce61a3ce12@oss.qualcomm.com?part=3D2
