Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA353477E58;
	Tue, 14 Jul 2026 13:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784037392; cv=none; b=szPFcLdY8v2S3G0oSw2K+B2vq+Czy0rqp+neMYGzVnzgIoAu4JXlgejM64lPvF0IqfY/QBokIrdW7+3nExXrPlUGKxqCsAxiFgLGFK5ZgUZu32QB2bfOhZHY/+VBmM1q2E9CBmG78b7ZiTHVbGWWVjwAr3WsT8HsAwQYjfApTik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784037392; c=relaxed/simple;
	bh=fRiZB8tA7lW4ibBkFR5cfmbaWFeHNxE6TXPzbWhUWiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ENXoAfyWkAYrgQs3KmcRX9galLO+J0YwdMy/JQEMJENQxhooV3S39OSZ7qnIQ4Lekgk3ziB77rAtISy1QDReLU0cBS1kDZpdFW+gFaGKPpQYWDE6piAvIJFRgWfM1rhAcI5cyWd6+BsEPn1/p71wEUKsbq67AvhYz1HuQ2y03Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aAnB2vu9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aAnB2vu9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B19AF1F000E9;
	Tue, 14 Jul 2026 13:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784037390;
	bh=JDSPBH8kmN8yWl3cpRdFds2lHGQF/dri6Vcet/2h+xk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aAnB2vu9e/YKC+BpOiBBbngLjlm+aVOzjKEZDie2L9tFORrca4yaTOjWMFjzQilYD
	 /3NiqemGIalkfC0yUSL8wHR7XnvLVZpCODMcvb0FT+EHdwmf8Y9449O69za8DG9m30
	 jYMC9gN1VtabrOqMuLIHxR0GBCSNIHshk6T5/ol46naeqMpVtJV9/OX2Ma/G6rqnL9
	 DgFL+ijhELAHMmjyEr9uPQc9fn27WGHIp4N8IrR0m7MZj70PC2QBQXHiddx/25Swsp
	 Df0fna0kZ5UdLfKuBKDl+PgEOQyYUK3T/XCkXB3QXvHKGukBA+w6iFlvLaJcoQB6YQ
	 Pwgds6ytJD31Q==
Date: Tue, 14 Jul 2026 15:56:20 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Wei Deng <wei.deng@oss.qualcomm.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, Chen-Yu Tsai <wenst@chromium.org>, 
	mengshi.wu@oss.qualcomm.com, quic_chezhou@quicinc.com, cheng.jiang@oss.qualcomm.com, 
	shuai.zhang@oss.qualcomm.com, jinwang.li@oss.qualcomm.com, xiuzhuo.shang@oss.qualcomm.com
Subject: Re: [PATCH 3/3] power: sequencing: pcie-m2: Deassert W_DISABLE2#
 when no UART serdev is created
Message-ID: <bjcmn2euhpik54ytc7falqgcezvy2loimudm6v2ibzxx6autki@rex5cjq2o755>
References: <gatls7n4xes7mrnhgxwsjof7owpocdmjrvuxazedznwa3zeb22@q3mtufc5dzkv>
 <20260713091616.4092086-1-wei.deng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260713091616.4092086-1-wei.deng@oss.qualcomm.com>

On Mon, Jul 13, 2026 at 02:46:16PM +0530, Wei Deng wrote:
> On Thu, 9 Jul 2026, Dmitry Baryshkov wrote:
> > On Thu, Jul 09, 2026 at 12:59:42PM +0530, Wei Deng wrote:
> > > The pwrseq_m2_pci_ids[] table lists PCIe BT devices that use UART as the
> > > BT transport and need a UART serdev created by the driver. When a PCIe
> > > device under the M.2 connector does not match any entry in this table,
> > > no UART serdev is created.
> > > 
> > > However, the BT subsystem of such a device may still require W_DISABLE2#
> > > to be deasserted to power up. Rather than adding every possible non-UART
> > > BT device ID to the table, add an else branch that deasserts W_DISABLE2#
> > > whenever a PCIe device is detected under the connector but does not match
> > > a UART BT entry. This allows any BT interface on the card (USB or other)
> > > to enumerate without requiring explicit knowledge of its device ID.
> > > 
> > > The primary use case is USB BT variants of combo chips that share the
> > > same PCIe device ID as their UART counterpart (e.g. WCN7851 NCM865 USB,
> > > sub 0x3378, vs NCM865A UART, sub 0x337c): no UART serdev is needed, but
> > > W_DISABLE2# must be deasserted so the USB BT device can enumerate.
> > 
> > Instead of forcibly toggling it, would it be more sensible to tie pwrseq
> > into the USB too? The onboard-usb-dev implements the same idea (of
> > powering up the USB device), but it predates pwrseq.
> > 
> > > Reassert W_DISABLE2# symmetrically when the PCIe device is removed.
> > > 
> > > Validated on Hamoa EVK (IQ-X7181-EVK) with WCN7851 NCM865 USB card
> > > (sub 0x3378): without this change GPIO116 (W_DISABLE2#) stays low and
> > > no BT interface appears; with this change GPIO116 is driven high and the
> > > USB BT device enumerates and comes up via btusb.
> > > 
> > > Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
> > > ---
> > >  drivers/power/sequencing/pwrseq-pcie-m2.c | 33 +++++++++++++++++++++----------
> > >  1 file changed, 23 insertions(+), 10 deletions(-)
> > > 
> > 
> > -- 
> > With best wishes
> > Dmitry
> > 
> 
> Hi Dmitry,
> 
> There is a patch series from Chen-Yu Tsai that appears to implement what
> you suggested:
> 
>   [PATCH v4 00/14] arm64: mediatek: Add M.2 E-key slot on Chromebooks
>   https://lore.kernel.org/all/20260709095726.704448-1-wenst@chromium.org/
> 
> We have been testing this on the Qualcomm Hamoa IoT EVK with both UART BT
> and USB BT M.2 cards.  Is this the direction you had in mind?
> 

IMO, we should move towards Chen's series.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
