Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795415085;
	b=cDCZyzVl/FX81BfBFVzgRLUPBGncsctx8g8UoUmeiuJ/t9CPqjOg4/UQWWzNEi7e8+B9
	 h4t/KUFTNP6cIIWN8nEkRjnpxNh6Szam6iyVukwsPLES7Ne/0VQGq8wT6QxgZT4i5Ymc/
	 HjqocgvAywRRGteFEgMrcsXgOIPW8G+7+3wZkLUa02cRR97XOh/7B0dtzst9QTdp80Ov5
	 Lbd+xHdibSGGSfb/GHvWvj5fX5HUt0nwSlOIk4ANZ4dT9IWbZukRnferAWg47x+73UniQ
	 E2BOvCB5m+5IO3goOb59PynfUf1k2RuQshZHmm7eQwQi6YodaSR6lTCP88p3Vu8cfLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795415085;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=7Spu6iERSMp8X5jycD4uaqYLUWuaLmQA+SUdHGO231I=;
	b=BbJiTZUJNKK++Mm6TPPOP81ZFDuxTyBqzP+1/TUj3cVtsF2gWVa1H9DF6hPOelvBTWPR
	 AiCrzWLoNRFdI1XOQdFY8RG4PI0J501JK/I0/sI9wTvMUUJ7xXrpTAR48Ud66cKvk7Bz7
	 6kQdYwXnsI0rOmLAVqpVFQaoUbxP/Bk+W60pdJCIVKgF+ZLZ5ZmC43RMhZaTQ1uSpM1kt
	 woI8XhqHvf3PoLvw2Tqv5XKnvivFh0C27FU+pzVIBZ4GRe67xQ98/yXWkhZhgNI+xAHwu
	 wtRU15I0/7Vb4i8Yy/0YjHK1EhgnxPUUgNnmCt8oYVfmWzu5/a3jw8Y2vyBWCpG80qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fTFysfv9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607E8606A31E;
	Mon, 23 Nov 2026 06:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fTFysfv9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E2981F000C0;
	Mon, 23 Nov 2026 06:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795415084;
	bh=7Spu6iERSMp8X5jycD4uaqYLUWuaLmQA+SUdHGO231I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fTFysfv9y+1eQJV7/sIm78b0uaInwqHQrYtSRrs9/+vW/ZcpifhXcRHBzjRtyInUR
	 z8Uj59oGbZw0faZ3k9xBq4zycIIKS1BzcUXqDMHyE5UzDQrDikHDCsSy4JvvXrteMV
	 ql3vZx7j3VZ8F/k5YDYi6JYFrKiYJ/pqMZv09/+6q32tEbkhs8M3JHys3WEFnU/IYZ
	 hnUZ8dmnSNfIONVq9PceAMwvwbT9ptf20GsbITJltShk98CO70lYTzaW0xqwoCp+CY
	 prjdzUCVfsaxo74rrEQ/ChZThNRG5BSim1GmX6ghNs5LfjrAoWZ7QQlVAbsigKH95o
	 Vr1yHTtLuEUlw==
Date: Mon, 23 Nov 2026 08:24:39 +0200
From: Leon Romanovsky <leon@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-sound@vger.kernel.org,
	dmitry.torokhov@gmail.com
Subject: Re: [PATCH v3 02/31] Bluetooth: btusb: Fix MediaTek ISO claim locking
Message-ID: <20261123062439.GH14811@unreal>
References: <20261118-device-trust-core-v3-0-d655875c4bfb@nvidia.com>
 <20261118-device-trust-core-v3-2-d655875c4bfb@nvidia.com>
 <sashiko-outbox-223888@kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-223888@kernel.org>

On Thu, Nov 19, 2026 at 07:29:22PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [High] Bluetooth: btusb: btusb_mtk_setup() aborts when interface 2 is
>   claimed by Wi-Fi
> --
> 
> commit 40159ea2da44fd76ee32a7e5d004d0dc5227de46
> Author: Leon Romanovsky <leon@kernel.org>
> 
> Bluetooth: btusb: Fix MediaTek ISO claim locking
> 
> This commit resumes the USB interface, acquires the parent device lock with
> bounded retries before claiming the MediaTek ISO interface, and propagates
> claim errors to btusb_mtk_setup().
> 
> > diff --git a/drivers/bluetooth/btusb_main.c b/drivers/bluetooth/btusb_main.c
> > index 92a78a7e60396..8307fd819cc2e 100644
> > --- a/drivers/bluetooth/btusb_main.c
> > +++ b/drivers/bluetooth/btusb_main.c
> > @@ -2993,40 +2993,57 @@ static int btusb_recv_event_realtek(struct hci_dev *hdev, struct sk_buff *skb)
> >  	return hci_recv_frame(hdev, skb);
> >  }
> >  
> > -static void btusb_mtk_claim_iso_intf(struct btusb_data *data)
> > +#define BTUSB_MTK_ISO_LOCK_TRIES	5
> > +static int btusb_mtk_claim_iso_intf(struct btusb_data *data)
> >  {
> >  	struct btmtk_data *btmtk_data;
> > -	int err;
> > +	int err, i;
> >  
> >  	if (!data->hdev)
> > -		return;
> > +		return 0;
> >  
> >  	btmtk_data = hci_get_priv(data->hdev);
> >  	if (!btmtk_data)
> > -		return;
> > +		return 0;
> >  
> >  	if (!btmtk_data->isopkt_intf) {
> >  		bt_dev_err(data->hdev, "Can't claim NULL iso interface");
> > -		return;
> > +		return 0;
> >  	}
> >  
> > -	/*
> > -	 * The function usb_driver_claim_interface() is documented to need
> > -	 * locks held if it's not called from a probe routine. The code here
> > -	 * is called from the hci_power_on workqueue, so grab the lock.
> > -	 */
> > +	err = usb_autopm_get_interface(data->intf);
> > +	if (err)
> > +		goto err_clear_iso_intf;
> > +
> > +	/* Disconnect may hold the parent lock while waiting for this work. */
> > +	for (i = 0; i < BTUSB_MTK_ISO_LOCK_TRIES; i++) {
> > +		err = usb_lock_device_for_reset(data->udev, data->intf);
> > +		if (err != -EBUSY)
> > +			break;
> > +	}
> > +	if (err)
> > +		goto err_put_interface;
> > +
> >  	device_lock(&btmtk_data->isopkt_intf->dev);
> >  	err = usb_driver_claim_interface(&btusb_driver,
> >  					 btmtk_data->isopkt_intf, data);
> >  	device_unlock(&btmtk_data->isopkt_intf->dev);
> > -	if (err < 0) {
> > -		btmtk_data->isopkt_intf = NULL;
> > -		bt_dev_err(data->hdev, "Failed to claim iso interface: %d", err);
> > -		return;
> > -	}
> > +	if (err)
> > +		goto err_unlock;
> >  
> > -	set_bit(BTMTK_ISOPKT_OVER_INTR, &btmtk_data->flags);
> >  	init_usb_anchor(&btmtk_data->isopkt_anchor);
> > +	set_bit(BTMTK_ISOPKT_OVER_INTR, &btmtk_data->flags);
> > +	usb_unlock_device(data->udev);
> > +	usb_autopm_put_interface(data->intf);
> > +	return 0;
> > +
> > +err_unlock:
> > +	usb_unlock_device(data->udev);
> > +err_put_interface:
> > +	usb_autopm_put_interface(data->intf);
> > +err_clear_iso_intf:
> > +	bt_dev_err(data->hdev, "Failed to claim iso interface: %d", err);
> > +	return err;
> >  }
> >  
> >  static void btusb_mtk_release_iso_intf(struct hci_dev *hdev)
> > @@ -3169,7 +3186,11 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
> >  	/* Claim ISO data interface and endpoint */
> >  	if (!test_bit(BTMTK_ISOPKT_OVER_INTR, &btmtk_data->flags)) {
> >  		btmtk_data->isopkt_intf = usb_ifnum_to_if(data->udev, MTK_ISO_IFNUM);
> > -		btusb_mtk_claim_iso_intf(data);
> > +		err = btusb_mtk_claim_iso_intf(data);
> > +		if (err) {
> > +			btmtk_data->isopkt_intf = NULL;
> > +			return err;
> > +		}
> >  	}
> >  
> >  	err = btmtk_usb_setup(hdev);
> 
> [Severity: High]
> Does propagating the usb_driver_claim_interface() error abort
> btusb_mtk_setup() on composite MediaTek Wi-Fi/Bluetooth USB devices where
> interface 2 (MTK_ISO_IFNUM) belongs to Wi-Fi?

Yes, Sashiko's findings are correct. I don't think the MediaTek examples are
correct, but that is less important. We need to fix this to support devices
with multiple interfaces.

Thanks

> 
> btusb_mtk_setup() runs for all BTUSB_MEDIATEK devices and unconditionally
> attempts to claim interface 2 before btmtk_usb_setup() identifies the chip.
> On composite devices such as MT7663U (0e8d:7663, 043e:310c), MT7921U
> (0e8d:7961) and MT7925U (0e8d:7925), interface 2 is the vendor-specific
> Wi-Fi interface bound to mt76 (mt7615u, mt7921u, mt7925u).
> 
> Because usb_set_configuration() holds the parent device lock while probing
> all interfaces and btusb_mtk_claim_iso_intf() now waits for that lock from
> the hci_power_on workqueue, the Wi-Fi driver binds to interface 2 first.
> usb_driver_claim_interface() then returns -EBUSY, and returning that error
> from btusb_mtk_setup() prevents Bluetooth from powering on instead of
> continuing without the optional ISO-over-interrupt interface.
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261118-device-trust-core-v3-0-d655875c4bfb@nvidia.com?part=2
> 
