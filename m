Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFF44F30F8;
	Fri,  4 Sep 2026 15:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788537546; cv=none; b=sdiXCCrBDjBl3p/OG0e9d/WQUy+nX6SKZGErfBRJ5aUny6ADIA1YUfgPKY6P3awJOMXPBx6NOHi0OykV9ZN36s7xgxaG3Yka9PwfTkeLCHKVWuCdqb3qHHGlDXcWV8fOJ1rmADv8j2XfNBQFntMUv63FuZz6vHSHcrvBhOkfEsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788537546; c=relaxed/simple;
	bh=N0ZMZbxc3wVBGGq3SRwADP8alTiT+zttKirXQLDIVXU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Rt69jo3czW+akcBp+YcWIX/tMXWSaJK45tkjUiyggPLJqsaGWbZyBHK9Ox7ebe6JsG/4+WZQhC9GhMhp1AQf0X4bt4JM84NB27ZSfX+J0koJ+dmU3rb5YgPBWqBQ0AErBNMMAEXyBG+ZFhQRNxKVhrw/tCS8qUSswmjghdRIbgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gyFXFUMU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gyFXFUMU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBBC1F0155D;
	Fri,  4 Sep 2026 15:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788537544;
	bh=N0ZMZbxc3wVBGGq3SRwADP8alTiT+zttKirXQLDIVXU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gyFXFUMUUkzHAiTgko6Xpny1WPRCU0FuaFvvQVXnlcS/AqnLgnob6L5IySMo8N0HR
	 8fhEwt4opfQm0ZvaB46MsPPTJZvF9oPYYzgw2biRJegxPiQe+gXn9HEU8l+wEGOMUC
	 nbqwapsMlO7fFik9xqoYeAoBMMzn0b1uGk7fOc/xVXCWgEC9xyXeKf75LiHrT2p/TP
	 44eXZKb7P2OXrQS5viXpjAhmig9E6ykIKwdNk6ytUnkolR9W4rlNaonxsg2l1Ikdwz
	 f1yzHtk6oGDgpdZm+XLKbmbsouqd3BOCv8sa0QunUe2VppvtWuWvTFtGKYMU/oQBvF
	 WMR8r9gFgWSbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 06/11] Bluetooth: hci_qca: Set 'bt_en_available'
 based on pwrseq power controllability
Reply-To: sashiko-reviews@lists.linux.dev
To: "Loic Poulain" <loic.poulain@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260904-monza-wireless-v6-6-d8c5042b3efd@oss.qualcomm.com>
References: <20260904-monza-wireless-v6-0-d8c5042b3efd@oss.qualcomm.com>
 <20260904-monza-wireless-v6-6-d8c5042b3efd@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 15:59:03 +0000
Message-Id: <20260904155903.EEBBC1F0155D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> A Bluetooth device only needs the non-persistent setup if the host can
> gate its power, so that it is actually reset on the next power-on. When t=
he
> power is controlled by a power sequencer, whether the host can gate it
> depends on the hardware wiring, e.g. the presence of the BT_EN or
> W_DISABLE2# line.
>=20
> Query the generic pwrseq_is_controllable() helper whenever the BT power
> comes from a sequencer, regardless of which provider it is (M2, WCN, ...).
> If the power is not controllable, clear 'bt_en_available' so that
> HCI_QUIRK_NON_PERSISTENT_SETUP is not set.
>=20
> This is based on Manivannan's original patch that keyed the decision off
> the W_DISABLE2# device tree property, it now uses the generic pwrseq help=
er
> and handles the always-on case.
>=20
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.co=
m>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-monza-wire=
less-v6-0-d8c5042b3efd@oss.qualcomm.com?part=3D6

