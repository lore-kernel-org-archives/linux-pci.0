Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B973241F34F;
	Thu, 16 Jul 2026 14:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784213708; cv=none; b=BOy6+H5a1kfhxHQy19V8tLTB7NmIDz4WzoYO9QbchQV6ESxJhop06mb1gSF+3jlm0aXlFRsOxHhn7b70aUyxJFE+FgHmVC280OVQRvJT4VfFmS/MhDbB9tZhOb2aOdnhsi7EDYBdmr2VU4ldXieDHgfpUNmKYrRmoTdnQ0spaos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784213708; c=relaxed/simple;
	bh=QPXzYC7aJAyMZ8qXkdMg9nSOu5NR+C5dX2ObE+xHvO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObFkJCKBL1jpOsOXGjMX2XgJxdnXsXH/PX/wKBNlMLNwcZ1aNLuA9RAqr+r/SX7TjqfdamO6PDwuu9FHnYFivLyyQ1XyQ5/UFtqPYCwmmt2EAYXxC9OjQtVOtHPiJ0Oa8NgOLEc27e+GLQ0dDu7N8srqRdq2qf9+OZ+gWLwXYhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKDGu3UK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKDGu3UK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B2401F000E9;
	Thu, 16 Jul 2026 14:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784213707;
	bh=tDnuHx/uNNAtdx+Sscmk413tjK8ehUVkgPcFHppaN1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SKDGu3UKR4eExL3dtV0ymdJf8+SDK6QSCpo3b8PvVcSpGHLx636Jf7WYZbT+EJ1wr
	 bd7JEI00HTkLjY/COx4e+IVN3nBMOXgaYsYHKeRsfMadUD5yhlXKwJoksU5vYHrZSZ
	 +PEmz8sYoGz0xlGIICwMhRYTYIOvOrrcMqpmxPX5FxNBqkj2kFB4ru/F6SP7NniHqD
	 LP111RltO9GD9zOrSxotWCk0yTp+Zt/Ko1HisJrjJzLXX5V/OZCMrsuHyW+6PCQT2o
	 pk1oAfp9jhcJGF4Cwm9SoyUmmrYRhIZ2mnqP1cMkUiJOGDxeQb9U8pO0F0562dHrAd
	 fYZ3bRFjZrw8g==
Date: Thu, 16 Jul 2026 16:54:47 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Wei Deng <wei.deng@oss.qualcomm.com>
Cc: dmitry.baryshkov@oss.qualcomm.com, andersson@kernel.org, 
	konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	brgl@kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	wenst@chromium.org, mengshi.wu@oss.qualcomm.com, quic_chezhou@quicinc.com, 
	cheng.jiang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com, jinwang.li@oss.qualcomm.com, 
	xiuzhuo.shang@oss.qualcomm.com
Subject: Re: [PATCH 3/3] power: sequencing: pcie-m2: Deassert W_DISABLE2#
 when no UART serdev is created
Message-ID: <s4c45lwdka6zebpttyljjla57sqyb7xaogndjeygyrqlvtthfd@t4q7n4wjsfly>
References: <bjcmn2euhpik54ytc7falqgcezvy2loimudm6v2ibzxx6autki@rex5cjq2o755>
 <20260715111622.2561730-1-wei.deng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260715111622.2561730-1-wei.deng@oss.qualcomm.com>

On Wed, Jul 15, 2026 at 04:46:22PM +0530, Wei Deng wrote:
> On Tue, 14 Jul 2026, Manivannan Sadhasivam wrote:
> > On Mon, Jul 13, 2026 at 02:46:16PM +0530, Wei Deng wrote:
> > > On Thu, 9 Jul 2026, Dmitry Baryshkov wrote:
> > > > On Thu, Jul 09, 2026 at 12:59:42PM +0530, Wei Deng wrote:
> > > > > The pwrseq_m2_pci_ids[] table lists PCIe BT devices that use UART as the
> > > > > BT transport and need a UART serdev created by the driver. When a PCIe
> > > > > device under the M.2 connector does not match any entry in this table,
> > > > > no UART serdev is created.
> > > > > 
> > > > > However, the BT subsystem of such a device may still require W_DISABLE2#
> > > > > to be deasserted to power up. Rather than adding every possible non-UART
> > > > > BT device ID to the table, add an else branch that deasserts W_DISABLE2#
> > > > > whenever a PCIe device is detected under the connector but does not match
> > > > > a UART BT entry. This allows any BT interface on the card (USB or other)
> > > > > to enumerate without requiring explicit knowledge of its device ID.
> > > > > 
> > > > > The primary use case is USB BT variants of combo chips that share the
> > > > > same PCIe device ID as their UART counterpart (e.g. WCN7851 NCM865 USB,
> > > > > sub 0x3378, vs NCM865A UART, sub 0x337c): no UART serdev is needed, but
> > > > > W_DISABLE2# must be deasserted so the USB BT device can enumerate.
> > > > 
> > > > Instead of forcibly toggling it, would it be more sensible to tie pwrseq
> > > > into the USB too? The onboard-usb-dev implements the same idea (of
> > > > powering up the USB device), but it predates pwrseq.
> > > > 
> > > > -- 
> > > > With best wishes
> > > > Dmitry
> > > > 
> > > 
> > > Hi Dmitry,
> > > 
> > > There is a patch series from Chen-Yu Tsai that appears to implement what
> > > you suggested:
> > > 
> > >   [PATCH v4 00/14] arm64: mediatek: Add M.2 E-key slot on Chromebooks
> > >   https://lore.kernel.org/all/20260709095726.704448-1-wenst@chromium.org/
> > > 
> > > We have been testing this on the Qualcomm Hamoa IoT EVK with both UART BT
> > > and USB BT M.2 cards.  Is this the direction you had in mind?
> > > 
> > 
> > IMO, we should move towards Chen's series.
> > 
> > - Mani
> 
> Agreed.
> 
> While testing Chen-Yu's v4 on the Qualcomm Hamoa IoT EVK with a board
> that needs to support both USB and UART BT cards, we found that the USB
> hub holds a reference to the "usb" pwrseq target permanently (acquired
> in hub_activate() and never released). When the UART BT driver later
> calls pwrseq_power_off(), the bt_unit enable_count only drops to 1 and
> bt_disable() is never invoked, leaving W_DISABLE2# deasserted. This
> prevents the BT chip from being properly reset, causing the next
> btmgmt power on to fail.
> 
> This issue is addressed in v5 Patch 14 by splitting the Bluetooth
> pwrseq unit into independent uart and usb units, each with their own
> reference count:
> 
>   [PATCH v5 00/16] arm64: mediatek: Add M.2 E-key slot on Chromebooks
>   https://lore.kernel.org/all/20260715085348.3457359-1-wenst@chromium.org/
> 
> The series still needs review from you and other maintainers.
> 

Cool, thanks for staying on top.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
