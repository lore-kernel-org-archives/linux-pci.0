Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3AD2D7398;
	Sun,  2 Aug 2026 03:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785641919; cv=none; b=B1YkheHDjLs94eLitcSIj6rH/iRldF+fr7dJZRTu0jxvi2B/ZykaAeE+bCuak2CQWowF8RlBpBZVlReEBB6sstw5NtM0SyCAJ74oivChLfrBBkpX3x7foMjDC4+70zJNX8oiNCD2+9t5fhCKQhi5jNcrKo0huwyN3wdwGEy5+7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785641919; c=relaxed/simple;
	bh=aF4RmHEruNGFHPMGVQ1ak9aHQShiwv1Ob0bELMip9Jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FyvwRQYD42q11ONS338lUC6ABcNwjeil+ViInWr8z7QByLOGisdYC5zEa2SGyDXaxyC0znRKXA5XcVkLLKy3xgG0d3Uim3eo0MGZloQU2lWn2aQgW3Pb6CxfePnkMlZ1I5P362lDIgSGe/hzzQ1wR827hZnuuPCtyk2uszL0O8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XeCjXlI7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XeCjXlI7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 345511F00AC4;
	Sun,  2 Aug 2026 03:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785641918;
	bh=+TexX9rPlZFjIyLEyoK3UWWn0etmeyXn6pzQ5byloqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XeCjXlI7tOSJ1PRf6kZmJ+3zMIhva3ED4OoRl69JiO5HGRYGBSw3MbWTQc14PjVKV
	 J06GMQRDQFrgwQQSV81JF0SlxOiiKT0Wl3TeMLsRSkOvI5YH03axrqJjKh/S4G4R2e
	 CUIwOg+4FlWZUbhzkuVWzOamOuCwy5MedrTo0lx0btBxZH7ltqdDaTvwdO0QxePL5z
	 Pl7KttgJacYwf/gtB6JSzwf17WzMCJ6ldHByp5lMcYmqp7Ym4hRL/Fziqp2cuU/LyL
	 rxiWWh0iLEOsvteD5u/MF+tXhD3SwID/hodrx2MiI+KsPNeZ5JyCiB2kyaJ2DkhdhX
	 /0wPNrcmAqG7Q==
Date: Sat, 1 Aug 2026 22:38:33 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Rahul Samana <rahul.samana@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	quic_mohamull@quicinc.com, quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
Subject: Re: [PATCH v2 6/6] arm64: dts: qcom: rb3gen2: add Industrial BT UART
 overlay
Message-ID: <am6572YrbAULTa88@baldur>
References: <20260727-rb3-industrial-bt-uart-v2-0-2d100f30e202@oss.qualcomm.com>
 <20260727-rb3-industrial-bt-uart-v2-6-2d100f30e202@oss.qualcomm.com>
 <794424df-4714-43a4-b4b8-e960998ad1f1@oss.qualcomm.com>
 <ce283ef7-2460-4fa4-a1f5-9757fd6b42b5@oss.qualcomm.com>
 <6d61d749-440f-40ad-82e5-e1e909afad06@oss.qualcomm.com>
 <b47345f1-1c7b-4424-9c6b-3dd02c0f4ab6@oss.qualcomm.com>
 <bf7821a2-d813-4f89-b891-9c26d228ae67@oss.qualcomm.com>
 <b5afd21c-4516-4a8c-bc8f-6598ec385d27@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5afd21c-4516-4a8c-bc8f-6598ec385d27@oss.qualcomm.com>

On Fri, Jul 31, 2026 at 11:20:07PM +0530, Rahul Samana wrote:
> 
> 
> On 31-07-2026 21:19, Konrad Dybcio wrote:
> > On 7/31/26 4:48 PM, Rahul Samana wrote:
> >>
> >>
> >> On 31-07-2026 18:20, Konrad Dybcio wrote:
> >>> On 7/31/26 8:53 AM, Rahul Samana wrote:
> >>>>
> >>>>
> >>>> On 29-07-2026 18:01, Konrad Dybcio wrote:
> >>>>> On 7/27/26 5:45 PM, Rahul Samana wrote:
> >>>>>> The reworked RB3 Gen 2 Industrial mezzanine keeps the common Industrial
> >>>>>> mezzanine hardware description but routes QCC2072 Bluetooth over UART4
> >>>>>> instead of the default Bluetooth-over-USB path.
> > 
> > I only noticed this now - are there 2 variants of the industrial
> > mezz being sold concurrently? Is the already-in-kernel one some
> > sort of a prototype SKU? i.e. should we support both?
> > 
> >>>>>>
> >>>>>> Build this variant by applying the common Industrial mezzanine overlay
> >>>>>> first, followed by the BT UART overlay. The overlay models the M.2 E-key
> >>>>>> connector graph endpoints for PCIe and UART, and disables the on-board
> >>>>>> WCN6750 PMU and UART7 path so the M.2 QCC2072 Bluetooth controller can be
> >>>>>> used instead.
> >>>>>
> >>>>> So is the onboard module disabled? Can we not just use two in parallel?
> >>>>>
> >>>>
> >>>> The Industrial mezzanine variants do not support the on-board WCN6750
> >>>> wireless path. The common Industrial mezzanine overlay already disables
> >>>> the on-board Wi-Fi node.
> >>>
> >>> What does 'do not support' it mean here? They are physically present
> >>> as part of the SoM, so unless the lanes are somehow diverted away,
> >>> why is it not?
> >>>
> >>> Konrad
> >>
> >> Hi Konrad,
> >>
> >> The WCN6750 module is physically present on the SoM. What I meant is that
> >> the current Industrial mezzanine devicetree already disables the on-board
> >> Wi-Fi path, and this BT UART variant followed the same board-level policy
> >> for the on-board Bluetooth UART/PMU path.
> > 
> > Okay, and do we know why that's the case in the first place?
> > 
> >> For the endpoint labels, I can move the UART endpoint to the SoC DTSI,
> >> kodiak.dtsi, as uart4_ep.
> > 
> > Please do
> > 
> >> For the PCIe endpoint, the PCIe path to the M.2 QCC2072 device is not the
> >> PCIe0 root port in kodiak.dtsi. In the composed devicetree, it is
> >> behind the Industrial mezzanine PCIe switch, under:
> >>
> >>     /soc@0/pcie@1c00000/pcie@0/pcie@0,0/pcie@2,0
> >>
> >>
> >> So placing pcie0_port0_ep in kodiak.dtsi would not describe the actual
> >> topology.
> > 
> > Yes, that was an omission from my side
> > 
> > 
> >> I tried adding a generic label/endpoint to that downstream port in the
> >> Industrial mezzanine overlay and referencing it from the BT UART overlay.
> >> However, when the overlays are compiled separately and then composed, that
> >> label is not available while applying the BT UART overlay, so the composed
> >> DTB build fails with FDT_ERR_NOTFOUND.
> > 
> > I think this generic description is simply not achievable today without
> > a bigger plan in place
> > 
> > Konrad
> 
> Hi Konrad, Dmitry,
> 
> Yes, both Industrial Kit variants need to be supported.
> 
> The default Industrial Kit uses the common Industrial mezzanine hardware
> description and continues to use the existing Bluetooth-over-USB path.

"Kit uses the common" what do you even mean?! The mezzanine is a
physical thing, it doesn't _use_ anything! The mezzanine exists and the
DeviceTree describe what it is.

> The
> reworked Industrial Kit variant keeps the rest of the Industrial mezzanine
> hardware the same, but routes Bluetooth over UART4 instead.
> 

Does "reworked mezzanine" mean what it usually does? I.e. that you have
taken the mezzanine and modified it?

[..]
> 
> I am open to other suggestions if there is a better way to model this within
> the current overlay structure.
> 

I don't think it's possible to give you other suggestions as you haven't
described what this thing is, you just explaining how you're hacking
something together and ask us to help adjust your hack without knowing
what it is you're trying to describe with your DeviceTree.

Regards,
Bjorn

> Thanks,
> Rahul
> 
