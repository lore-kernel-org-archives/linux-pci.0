Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795261291;
	b=GVd90mLGKUTOAKzVTnTRpdB9sU6bSxrLW7c9cYV0EVnyTERuiP96ZvN92UJfSphSVkp8
	 Cy5ZKC5wdDaTmBNnlcw64Jn45qx/UNwNB/1ZPyjXSFMhVdKYx//7h9ilThKcs3FhMGgQI
	 ADdkb6L53UfaqpLnBSUL4JXSI/+MqjYfR+MnXb6v1DjkjDuUTJbbUPkITYtWq4BTZu9HQ
	 FsFo76ddPPTBnXz5+bQjLp0gpKcMLU6YZhfuis84ISDoR07vUqxE4o4ziO9oRe0bfxGRH
	 x0f+uFxxqxTF2xbIDFyVR7Q7rcfIzcpFnk+wxdp0Cl5/2LLFGciR0P4j9mfMJVle21g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795261291;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DMLaRGaBDeWU3cEwuZwN/8a+jTch0V6mrAQu5NIsb0E=;
	b=xXGGbLWzW+luccAS/gSuXgNb/9hDEet/ntpCpe5DBEBNfdJv3GIoQCatxJ/fl7kHyo1N
	 Y2KwKSu+UGKwlA9aqiSVGAOyttrDte/AK7NkLPeaSFM2EHjgJLFFIhFz9WJRNfs0WPouq
	 NZKM/+zB7jKAY6ccJ+PlDDbApUAJa9+b3ttM3pezwCGyYR6aeCERT266GJhpIpsF0xDIQ
	 SB+eRqM5DOMgkrOE9I21GCmLSf2JToNBcgal6wuWXOul4bba9Nq969AScaz17Rnxq1EHA
	 IdvV8WdCZ8X6zf9XM/QoSZTYJOuNwk0fhC42JYjW1+Hb2YbKwvD7z6xdQ6rK7/40zZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oigQSJoo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA60606A32C
	for <linux-pci@vger.kernel.org>; Sat, 21 Nov 2026 11:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oigQSJoo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A34901F000C6;
	Sat, 21 Nov 2026 11:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795261290;
	bh=DMLaRGaBDeWU3cEwuZwN/8a+jTch0V6mrAQu5NIsb0E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oigQSJooBhhSFGLjvE0iHCBzRt0xFVfr4aFku0i8BmzZSGxnVvZMMipTbu+OFXtoT
	 cUczIayPHVPujP0XzbOLpNMLW7ifrzMipdTKpISIS6oy0ICpGWRS0gMHTPd2aoCm17
	 5rD7QcbxPvCnpzVi8SNWyOLxv+HCVZzcWFdrOorsrBD0IRECi9EkW4z+RWSQem9Eeo
	 j3J5vogBmRcjFHYgsiUT/TMCVrZx/IoXGuK8ikHPpCq1uXQcMQ74kmpb+RXCO4ZNAj
	 Cy31XeLZq9jTdFafZYCB2iaomAv6Zkn0KIZm7ezYLvSM3kzwqb+fOsPyN2/ujA+5Ah
	 pifPYMS1k9EHw==
Message-ID: <sashiko-outbox-226985@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: qcom: Do not power off a PHY whose power-on failed
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muhammad Huda Nugroho" <mhudan21@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261121113721.7OL6u%mhudan21@gmail.com>
References: <20261121113721.7OL6u%mhudan21@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 11:41:30 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] PCI: qcom: missing Fixes trailer for qcom_pcie_phy_power_on()
  unwind fix
--

commit e8e6c447938093b506280d02a806164618cf331c
Author: Muhammad Huda Nugroho <mhudan21@gmail.com>

> PCI: qcom: Do not power off a PHY whose power-on failed
>
> qcom_pcie_phy_power_on() unwinds a failed phy_power_on() by calling
> qcom_pcie_phy_power_off(), which walks the whole port list - including
> the port that just failed, and every port the loop has not reached yet.
> The phy_set_mode_ext() failure path returns without unwinding at all,
> leaking the ports already powered on.
>
> The first of those is not a leak but a refcount underflow.
> phy_power_off() decrements phy->power_count unconditionally and invokes
> the provider's ->power_off only at a count of 1, while phy_power_on()
> invokes ->power_on only at a count of 0. Releasing a reference that was
> never acquired therefore drives the count to -1, and the next
> phy_power_on() returns success having silently skipped powering the PHY
> up: no error, no message, just a PHY that is never initialised again.
>
> The damage outlives the failed attempt, which is what makes it worth
> fixing. On a single-port controller the very first failure is enough to
> reach -1. It is normally invisible because a failed host init at probe
> time is fatal anyway, but it becomes reachable as soon as anything
> retries host init at runtime, as system resume does - at which point the
> controller comes back with a PHY the core believes is already on.
>
> Unwind with list_for_each_entry_continue_reverse() so that only the
> ports successfully powered on are powered off, and route the
> phy_set_mode_ext() failure through the same unwind. The PHY core already
> releases the failed acquisition itself, so the failing port must not be
> released here.
>
> Signed-off-by: Muhammad Huda Nugroho <mhudan21@gmail.com>

[Severity: Low]
This fixes the error unwind in qcom_pcie_phy_power_on().  Should this
include:

  Fixes: a2fbecdbbb9d ("PCI: qcom: Add support for parsing the new Root Por=
t binding")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121113721.7OL6=
u%mhudan21@gmail.com?part=3D1
