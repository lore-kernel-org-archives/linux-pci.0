Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6C1346798;
	Fri,  9 Oct 2026 07:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791532761; cv=none; b=nQohHvGD6yMDT3/MInwnaq0dqfuPk96S/j7QL4oTRzXi0gqF8JLecRH5MSOqrRxaKJ8h2j3X2zEI3RZH85E555295DVN0D+kWLQJ4IqjV+n2RgI0XjkiEWVOGHb5cj0DGTNmA29BJ8qHxWD57I0YRRQoCbjaWDqV6wUxssshkJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791532761; c=relaxed/simple;
	bh=gXtPib0RE6hspBksSoMJbmzs7zXiRey/gqluAFwnhtw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ZuLrA9mxStqwf60ZPdtB7dyd390JBsMV+WzdkBuvvF9WRJD7tjlYLALu6bKz2PohUKWxUqWwp8FC8I5nFcggMq/wunWi+awt57C6ClaeKDDjml2gi2Bjq1KqOLR1LaJKEdhjcBjq42fY9IspWNLEZZ8STjKMeWPpkJg4nIOoeak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MqKMQ7be; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MqKMQ7be"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F7A1F000FF;
	Fri,  9 Oct 2026 07:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791532753;
	bh=gXtPib0RE6hspBksSoMJbmzs7zXiRey/gqluAFwnhtw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MqKMQ7be+yDDSQFsXrzRrr4Ynwe3UHvHmHhjZ6+j/X8Npcaku3P3JiUebD4QIg2Bv
	 bD+gAvKgnAAqB0NOgZcxHk0s8k+66VRRUuzNLIbmnC5ijDd6/gl6KpP9BNvyrBsId6
	 WZyFtCigxBq2Kso6gQwSaEz5vrJO96BTk62xMma3KyJZXSyHGEL/P/9h4Et8Z3yYam
	 rGn74vMtz0vAuG0850gFB4EzSfzvAf0gtnFFSvZNMLC0pacnaqNMwa0ACOe3EDOk7k
	 IkG9ecGcB3p418eF2kAi5eA/m4w4X0HXoFrF91ZpJfR4RWBsYJt/Y8vAkw/0b+IQLK
	 P10QYpmwH0Wfg==
Message-ID: <sashiko-outbox-165047@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] dt-bindings: arm: qcom: document Radxa Dragon
 Q8B
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xilin Wu" <sophon@radxa.com>
Cc: conor+dt@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, robh@kernel.org, linux-gpio@vger.kernel.org
In-Reply-To: <20261009-q8b-dts-v2-3-eda11e5dea8b@radxa.com>
References: <20261009-q8b-dts-v2-0-eda11e5dea8b@radxa.com>
 <20261009-q8b-dts-v2-3-eda11e5dea8b@radxa.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 07:59:12 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The Radxa Dragon Q8B is a single-board computer based on the Qualcomm
> SC8280XP platform.
>=20
> Document its radxa,dragon-q8b compatible.
>=20
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Tested-by: Daniele Briguglio <hello@superkali.me>
> Signed-off-by: Xilin Wu <sophon@radxa.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-q8b-dts-v2=
-0-eda11e5dea8b@radxa.com?part=3D3

