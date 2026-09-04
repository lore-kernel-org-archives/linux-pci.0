Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EC142589D;
	Fri,  4 Sep 2026 15:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788537137; cv=none; b=c5+mEV2TtX2yqb1/Dl2TO0UFepCw3lE2qNZtPFJ0IjTxzIgPG6gAKs7fwdEp/+Gg7c0qvPzM0oI8CLQI6zODp620AnTX9zM5KplME7FNo67kLCmU9gi+tE0X5vZ8TVdsQSPBDaFDavzrgUiGE/cRhRqoPUClWizFeCHcQ1uYC0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788537137; c=relaxed/simple;
	bh=ABDWIakCveBu1w1ZhxR2jRxjKjH+Z5AuMVBOhnan1FI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Xbspy7BeX7cvQuq2m37aIRFW4Mh0WkjH4frcs2W6PpxyaNDCLak09MzgEzUKdCXSysnrcvtg3NgI/yHSUEUUI8v+h24FYsDT+ZMmvT/kwH9818WkzARFVTvP//3Gc29ndP7JIYmnQVkLIg5Dx5hC4Q1fbaq6WqVH6NfwqRRk3GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XT3Z8P2a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XT3Z8P2a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F581F00A3D;
	Fri,  4 Sep 2026 15:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788537135;
	bh=ABDWIakCveBu1w1ZhxR2jRxjKjH+Z5AuMVBOhnan1FI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XT3Z8P2aishMFYqh54vf9NgBEJTara10l20amVbUtYZDKTvAcpIZVw5dpRnwtLeHw
	 R43jg5G0/5txyVGuVTMOM1/AqMtsrOEP+KL7ZBGQjhBmEk3Pn31c2+HCk+hQofyW50
	 FR8XWOL+U8I1u/DBZ56S3Ge4SfJ2F2q1u+txOHmkl4MWbQH2LeaT7Nvl3UTksowcDN
	 jXHeTPm/PdnG+EWkqHkrpgmSbmkGtIFikI2Pn0xvij3D/bHgSOE9Q/8zLTFu0tfJ2x
	 k28UKDKE8IoZs7GqIv0XIXV0qPAtMqRGFcqjftCRRon4nHsCCLjXMSsqVZvubciB0x
	 XQFj6bqwTJB7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 03/11] power: sequencing: Add
 pwrseq_is_controllable() API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Loic Poulain" <loic.poulain@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260904-monza-wireless-v6-3-d8c5042b3efd@oss.qualcomm.com>
References: <20260904-monza-wireless-v6-0-d8c5042b3efd@oss.qualcomm.com>
 <20260904-monza-wireless-v6-3-d8c5042b3efd@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 15:52:15 +0000
Message-Id: <20260904155215.83F581F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> On some boards a power sequencing target has no host-controllable enable
> for its function, for instance when the enable line is not wired up to a
> GPIO and is hardwired to an always-on level. The pcie-m2 "uart" target is
> one such example: when the M.2 connector does not route the W_DISABLE2#
> signal to a host GPIO, its enable/disable are no-ops and the consumer
> cannot gate the Bluetooth function at all or exclusively.
>=20
> Add a generic pwrseq_is_controllable() helper. It reports whether the
> target's final unit provides a host-controllable dedicated power actuator.
> The target can implement a new optional is_controllable() callback,
> reporting whether that actuator is effective on this target (for example
> depending on GPIO presence). If the target does not provide the callback,
> it is assumed to be controllable.
>=20
> Note this only describes the target's own enable actuator. It does not
> imply that a power-off reaches an electrical OFF state, since a target may
> have multiple consumers. It also does not mean that power is uncontrolled
> for the target's dependencies: those may still be gated on their own. And
> it does not restrict consumers from calling pwrseq_power_off() either,
> which remains valid to drop this consumer's vote on the (possibly shared)
> resources and dependencies of the target.
>=20
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.co=
m>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-monza-wire=
less-v6-0-d8c5042b3efd@oss.qualcomm.com?part=3D3

