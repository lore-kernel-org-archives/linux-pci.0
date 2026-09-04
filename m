Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8583F12E1;
	Fri,  4 Sep 2026 15:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788537227; cv=none; b=SQr8HAHJzFcALpyrkRQUBNPSn/E4xsuvnx1NjRHMqZ3x6NC+WG5rMMLJmLbwE5usNwHwOm4nFUMgZU1aXi5BoRyhPOeJ809fWZbNip1Qyv33LlaHspd0HZJanQ3JbCSfcpQ8BTf1gVsl3Fel85TH0qRtjltOsdvDrJw0aE+pyEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788537227; c=relaxed/simple;
	bh=ceesWNRkHUNu9c1Uje5Wmu0TnqSySa6CAzv8WpVdtkQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kRawa0PVBmVWSVgoGq2x4L7oOlYpnDZOcfqxvXm6UPXVZjc8kJy+N9DlDT90oJAmcUIfjKI1eyfz3E4A6+KCEfxKw/UrrCzLdhsVdX+Fnl6aO29SeeKSyk2eXGQjeoM4laiV4QlSusYa7iA7DnWhNhTQ3QrXMwYfbsFn19bwx/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5dkALTr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5dkALTr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624D71F00A3D;
	Fri,  4 Sep 2026 15:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788537226;
	bh=ceesWNRkHUNu9c1Uje5Wmu0TnqSySa6CAzv8WpVdtkQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T5dkALTrVmK4PlhtWYZlAEQ1vpZ/6Bttcln4ChlYRcfgfy3Dc2e020KcVQ78VXD3d
	 Np7Ufo5BNrnMBCcwjwAVH0WsEIi2GpWVNY3NII+Y77rsI0A7s+g1ezIkkKzlJIeMdE
	 GBKR0xpMXnAdtkf2rKL7+58M1WiutKfeCSNKtRuICH1yWQOIIijUJHxscpAnyJ9AhX
	 SMpP/EjySJ2o//aQ1Wl+FKEobtvi6ZzEn9juBCifrPxS4VSexWSem3PjZssOGZxD6b
	 iAYQuRlUDXm6Sa3l+g0fmmI4hnXEnb8JWU3sxTVshyBOjhPKvwGQpIvWezs7DhVW2K
	 GMmVa5LGXJxQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 07/11] Bluetooth: hci_qca: Embed bt_power in struct
 qca_serdev
Reply-To: sashiko-reviews@lists.linux.dev
To: "Loic Poulain" <loic.poulain@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260904-monza-wireless-v6-7-d8c5042b3efd@oss.qualcomm.com>
References: <20260904-monza-wireless-v6-0-d8c5042b3efd@oss.qualcomm.com>
 <20260904-monza-wireless-v6-7-d8c5042b3efd@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 15:53:46 +0000
Message-Id: <20260904155346.624D71F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> 'bt_power' is allocated dynamically only for a subset of SOC types, using=
 a
> switch on the SOC type that mirrors the one that follows it. This is about
> to become pointless as the power sequencer path (used by M.2 modules) is
> independent of the SOC type and needs 'bt_power' populated for any type.
>=20
> Embed 'struct qca_power' directly in 'struct qca_serdev' instead of
> allocating it separately. This drops the extra allocation and its dedicat=
ed
> SOC-type switch, and removes the need for NULL checks on the pointer.
>=20
> No functional change intended.
>=20
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-monza-wire=
less-v6-0-d8c5042b3efd@oss.qualcomm.com?part=3D7

