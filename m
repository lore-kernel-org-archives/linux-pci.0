Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31097513570;
	Fri,  4 Sep 2026 17:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788542608; cv=none; b=D0fEbhbNtqJ8ydSfXfOIaZSIpYJLg1sl0ZVCj8je7xZMT7g1ci3hIwml1yOqpXDqBi8ypcwbm7uzvLFDiOY00QTpfimh+7lnsN4GU/PM4XBDA6gFY3QcwQtjvMqyIaOFoPonDMQUvjvuEelVE0E9BPuqsSbvHDH9Y1Dhh+fTX44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788542608; c=relaxed/simple;
	bh=MNZJfyCO5PIiQ6u+gBcjeY7Md0qQTd/cwTCMPzUwamw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZhwFFBFXoPWv9aFrHETLguvQv4Eph2cyRt+yUIGxHG6P6cwYWpjxUxJc/6XCBymlpN+VHMsl1/Xc/AuWJhsGUCXXRWVYX53/eV3Z1wswx5fJVWPagf93OlpmHiKZcsrltgq+plqKfcarhkA7xKT2GgeJvE+DQmBT3kyOdu1HVYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QENHzmfe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QENHzmfe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 493911F00A3D;
	Fri,  4 Sep 2026 17:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788542606;
	bh=MNZJfyCO5PIiQ6u+gBcjeY7Md0qQTd/cwTCMPzUwamw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QENHzmfejRX6WZw0zUukfd7/p1HMLqs4FwvNwxzLcHNdljhqciyuF56zNoCjlXP/+
	 dflAw1yvrz1DXf/Uk8Oxbz33aowQCpksJAc+Wi3OkJNErFnfUf7lJ0leElzVNFPqtA
	 YVj0KkoAPJNxLGT3EUddHfIw/YN8mR1TvfVHtstycke+Z0/ePxkG/4nD3JUU0k3h8J
	 7iNhFlsNFLvCVVERTkdR43RMrqhYairxUpmHSdmmcQAo2r9J59begfTejEA4v3u+2U
	 3zoUikvisz1tp1KYU5Vg9BZegDbh4t5owWZ+IiU1RKDKAOXO8PsML/Utc5kyqtbFA3
	 Ebw/yfl/Mdsew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/5] arm64: dts: qcom: qcs6490-rb3gen2: Enable TC9563
 embedded GPIO controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lorenzo Bianconi" <lorenzo.bianconi@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260904-pci-tc9563-aux-v3-5-5b1449d62ba2@oss.qualcomm.com>
References: <20260904-pci-tc9563-aux-v3-0-5b1449d62ba2@oss.qualcomm.com>
 <20260904-pci-tc9563-aux-v3-5-5b1449d62ba2@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 17:23:25 +0000
Message-Id: <20260904172326.493911F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The Toshiba TC9563 PCIe switch embeds a GPIO controller providing 37 GPIO
> lines. The controller is registered as an auxiliary device by the TC9563
> power controller and accessed through the same i2c device.
>=20
> Describe the switch node itself as the embedded GPIO controller and us
> it to drive the PERST# reset lines of the two external downstream port
> (pcie@1,0 and pcie@2,0), as expected by the TC9563 power controller after
> switching to the GPIO descriptor API for per-port resets.
>=20
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-pci-tc9563=
-aux-v3-0-5b1449d62ba2@oss.qualcomm.com?part=3D5

