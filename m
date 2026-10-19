Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90133ADBAC
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 09:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792402184; cv=none; b=Nta7wuqhxFCO+Lm9duq8OVHKSNtN4sEvYP0tYjPj19Z6WYH7VMn40zuhuqGqOCMxJVWafa6wcEeZBxfyluU3OlSWqVjZuCWO8LXC8+DLmEY3j8LHrTAVL4C/jfmZRGkDGQcZgg7i8beoMu8vfk5p8OWazItaCV4L3BtA/uXUXd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792402184; c=relaxed/simple;
	bh=RJIWS5XP7/hHMaTz6e5pNPscPt/y6inC1EYk7JBjEpU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=BXSIg9EBUW/yY8JWr4TABkAQFZdJB0rCcZMfKBgb6T6D/aa9kAYgXdE2jTCBMojj9IDrZOOlShBXWbAI0bAzlVSY+RaJN2/BqmvzPh5ybaPTosCB0SxEhUjBe6vl0LaZBSG4LYzqDewbhac68rXon6YQV/9QCUXM75be7TKhQUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXH/e6ME; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXH/e6ME"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB951F000C5;
	Mon, 19 Oct 2026 09:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792402182;
	bh=RJIWS5XP7/hHMaTz6e5pNPscPt/y6inC1EYk7JBjEpU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JXH/e6MEVYobFTfDG9tV2U00OrZjUKL4C2GDwnqyrMp46zFK63EcbX3VHsMwNr1kh
	 XmB34aqOFf0STHIZf///cKRHF9LGdYFbZMNxgEZiSD+rqwm4dtdhNtreoF3MejyE5Z
	 HeuHFeS6+wMf7Aa6VyoiQkBXVC7X7plcnGM6Dr92KusmtKKKDpIeCzj0axph4LPcUI
	 lbaidGTuhVj2mb9qmhES9aAvFFiM8jRXzbBQQuS3nu8zuLMz49ADFUMJ1bxreGoIEu
	 IOPIMKb9z3/N5iwuXrL9O1W9l467ZbWxN8A5Zn+cniiyy8HKr6z017F7RNtHHsrQ0X
	 pOdMRFprwQ1tg==
Message-ID: <sashiko-outbox-176906@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/6] PCI: qcom-ep: Set initial interconnect bandwidth
 before enabling clocks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261019-monaco_ep-v2-4-852cb9f5d012@oss.qualcomm.com>
References: <20261019-monaco_ep-v2-0-852cb9f5d012@oss.qualcomm.com>
 <20261019-monaco_ep-v2-4-852cb9f5d012@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 09:29:41 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Some Qualcomm platforms require the interconnect bandwidth constraints
> to be set before enabling the interconnect clocks, otherwise some
> clocks get stuck in the off state.
>=20
> Move the icc_set_bw() call before clk_bulk_prepare_enable() so the
> bandwidth vote is in place first.
>=20
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019-monaco_ep-=
v2-0-852cb9f5d012@oss.qualcomm.com?part=3D4

