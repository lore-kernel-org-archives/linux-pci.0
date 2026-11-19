Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116563;
	b=tcASSaAfD4CsX9mXDTicNngtFD9fM5vx7ku5QwZjMQwuz22xXLdtjBELT+TA7t9FezJ7
	 v60kRIYNiBZeiGraRLw9i+BiQgaRCrQE/pvM44MfqyKQtfG1rCRMMEy7c1r3zO3J9hPEk
	 fsxkvkeUfrOr3ovxtpRlcebaoc6/qQHpipF9k7BCHAyr6IVW4o5FNGq/UJUl+OO2nYk87
	 8z3FCs0VgexeH6OQKjrkMbdLg0oIeKT23MS1KE3gPdKhgCAnAgkH9m9qfmd7z7n28On5k
	 uFWHR4Ap40x+vfFVLdgg+sGPPlMmDwaqLLSPk+UULl40suopHPykm8s/gLvv2doVvFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116563;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Cx7txrChHRR4iI6HBKKIjhsi+MVi8YdQAEKnvJVM03I=;
	b=GsrbVKWv1xkfM02w3mDIayShskzKEJ+xuO3ckVpJ5vYYXxGZYs19IwwQDJVKfQUEVezB
	 ckdFZOJe1X56+lI0rEZfIs8BWOMkMQEbl1esPkNEQbYLMforaEoHFU/1l1FFX6PfFWSHj
	 cOG7YNx0sk8xapksKwtesO0ljVNOaMhVCyHu3meQMK/db0KiiNvWBjf7azmltDOHOYoms
	 FaVmfxCel33gNdbMH+rdTjRdm4jf3fZCJsMTxDb9tv/SGTXvmp7iOUkUyj7dOG9a/r3pw
	 C1FsedhJhOqRCOfN4sxqyAGbH4G40EN76SRYbvTT6lypt8yGcXL0btbBOFXtmZE+aJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TK1ID6xK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4CD606A326;
	Thu, 19 Nov 2026 19:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TK1ID6xK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957C31F000C4;
	Thu, 19 Nov 2026 19:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795116562;
	bh=Cx7txrChHRR4iI6HBKKIjhsi+MVi8YdQAEKnvJVM03I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TK1ID6xKTisakgpjuJKz814WV4NWk0ta3zDbqoO3fdUmfxg89SOKCYyvFJSpNYRyE
	 6qYChCfmKEs4OZXrDbqk1fvAOO+X8ZxBNiry4GJXN+HeiyfW377K5AKbZJewOVhjga
	 6HqPIFSrLAG25LcTtqi7k9SrzYkKBO8otFyDloNT7BMtyVs+2jCYyFf8z5rXc9Iuf0
	 AOWaL4XjFpUbLoTZPZkmhNiSIIRrlBZwGIQyi15G5JWqxeE7iOPNAXG0fjdGF5e4U6
	 x2irZT1zVf2eCz/5lCXNAIbWayc+27mevye6DIXf5r7coOTUT+N45PNMEwtLoiKXc9
	 Kw/UKGAKigAcQ==
Message-ID: <sashiko-outbox-223888@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/31] Bluetooth: btusb: Fix MediaTek ISO claim
 locking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261118-device-trust-core-v3-2-d655875c4bfb@nvidia.com>
References: <20261118-device-trust-core-v3-0-d655875c4bfb@nvidia.com>
 <20261118-device-trust-core-v3-2-d655875c4bfb@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:29:22 +0000
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
- [High] Bluetooth: btusb: btusb_mtk_setup() aborts when interface 2 is
  claimed by Wi-Fi
--

commit 40159ea2da44fd76ee32a7e5d004d0dc5227de46
Author: Leon Romanovsky <leon@kernel.org>

Bluetooth: btusb: Fix MediaTek ISO claim locking

This commit resumes the USB interface, acquires the parent device lock with
bounded retries before claiming the MediaTek ISO interface, and propagates
claim errors to btusb_mtk_setup().

> diff --git a/drivers/bluetooth/btusb_main.c b/drivers/bluetooth/btusb_mai=
n.c
> index 92a78a7e60396..8307fd819cc2e 100644
> --- a/drivers/bluetooth/btusb_main.c
> +++ b/drivers/bluetooth/btusb_main.c
> @@ -2993,40 +2993,57 @@ static int btusb_recv_event_realtek(struct hci_de=
v *hdev, struct sk_buff *skb)
>  	return hci_recv_frame(hdev, skb);
>  }
> =20
> -static void btusb_mtk_claim_iso_intf(struct btusb_data *data)
> +#define BTUSB_MTK_ISO_LOCK_TRIES	5
> +static int btusb_mtk_claim_iso_intf(struct btusb_data *data)
>  {
>  	struct btmtk_data *btmtk_data;
> -	int err;
> +	int err, i;
> =20
>  	if (!data->hdev)
> -		return;
> +		return 0;
> =20
>  	btmtk_data =3D hci_get_priv(data->hdev);
>  	if (!btmtk_data)
> -		return;
> +		return 0;
> =20
>  	if (!btmtk_data->isopkt_intf) {
>  		bt_dev_err(data->hdev, "Can't claim NULL iso interface");
> -		return;
> +		return 0;
>  	}
> =20
> -	/*
> -	 * The function usb_driver_claim_interface() is documented to need
> -	 * locks held if it's not called from a probe routine. The code here
> -	 * is called from the hci_power_on workqueue, so grab the lock.
> -	 */
> +	err =3D usb_autopm_get_interface(data->intf);
> +	if (err)
> +		goto err_clear_iso_intf;
> +
> +	/* Disconnect may hold the parent lock while waiting for this work. */
> +	for (i =3D 0; i < BTUSB_MTK_ISO_LOCK_TRIES; i++) {
> +		err =3D usb_lock_device_for_reset(data->udev, data->intf);
> +		if (err !=3D -EBUSY)
> +			break;
> +	}
> +	if (err)
> +		goto err_put_interface;
> +
>  	device_lock(&btmtk_data->isopkt_intf->dev);
>  	err =3D usb_driver_claim_interface(&btusb_driver,
>  					 btmtk_data->isopkt_intf, data);
>  	device_unlock(&btmtk_data->isopkt_intf->dev);
> -	if (err < 0) {
> -		btmtk_data->isopkt_intf =3D NULL;
> -		bt_dev_err(data->hdev, "Failed to claim iso interface: %d", err);
> -		return;
> -	}
> +	if (err)
> +		goto err_unlock;
> =20
> -	set_bit(BTMTK_ISOPKT_OVER_INTR, &btmtk_data->flags);
>  	init_usb_anchor(&btmtk_data->isopkt_anchor);
> +	set_bit(BTMTK_ISOPKT_OVER_INTR, &btmtk_data->flags);
> +	usb_unlock_device(data->udev);
> +	usb_autopm_put_interface(data->intf);
> +	return 0;
> +
> +err_unlock:
> +	usb_unlock_device(data->udev);
> +err_put_interface:
> +	usb_autopm_put_interface(data->intf);
> +err_clear_iso_intf:
> +	bt_dev_err(data->hdev, "Failed to claim iso interface: %d", err);
> +	return err;
>  }
> =20
>  static void btusb_mtk_release_iso_intf(struct hci_dev *hdev)
> @@ -3169,7 +3186,11 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
>  	/* Claim ISO data interface and endpoint */
>  	if (!test_bit(BTMTK_ISOPKT_OVER_INTR, &btmtk_data->flags)) {
>  		btmtk_data->isopkt_intf =3D usb_ifnum_to_if(data->udev, MTK_ISO_IFNUM);
> -		btusb_mtk_claim_iso_intf(data);
> +		err =3D btusb_mtk_claim_iso_intf(data);
> +		if (err) {
> +			btmtk_data->isopkt_intf =3D NULL;
> +			return err;
> +		}
>  	}
> =20
>  	err =3D btmtk_usb_setup(hdev);

[Severity: High]
Does propagating the usb_driver_claim_interface() error abort
btusb_mtk_setup() on composite MediaTek Wi-Fi/Bluetooth USB devices where
interface 2 (MTK_ISO_IFNUM) belongs to Wi-Fi?

btusb_mtk_setup() runs for all BTUSB_MEDIATEK devices and unconditionally
attempts to claim interface 2 before btmtk_usb_setup() identifies the chip.
On composite devices such as MT7663U (0e8d:7663, 043e:310c), MT7921U
(0e8d:7961) and MT7925U (0e8d:7925), interface 2 is the vendor-specific
Wi-Fi interface bound to mt76 (mt7615u, mt7921u, mt7925u).

Because usb_set_configuration() holds the parent device lock while probing
all interfaces and btusb_mtk_claim_iso_intf() now waits for that lock from
the hci_power_on workqueue, the Wi-Fi driver binds to interface 2 first.
usb_driver_claim_interface() then returns -EBUSY, and returning that error
from btusb_mtk_setup() prevents Bluetooth from powering on instead of
continuing without the optional ISO-over-interrupt interface.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-device-tru=
st-core-v3-0-d655875c4bfb@nvidia.com?part=3D2
