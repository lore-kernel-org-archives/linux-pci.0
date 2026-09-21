Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9B745A2A0
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 09:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789984293; cv=none; b=cNK/BRkt0QvR2ghGPMQGu58NkaHqohjbEunYWSO547A/CVq3BoHeK11bkrC21fywks5hKtuCouScm5BHOrIE+8Akc8XUy0MTtQ6ygoTbGW7HZ4bOehuv2qe5PTOkDl6Cn9Czee7I3ujgCvZqceMvrPB1uLQUpvDQDxUAUF+5QXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789984293; c=relaxed/simple;
	bh=R9F7eCs5hlVe0XrQOYg+00J2R1c/rmdJwPU5ijIE2p4=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E2tHnWNJTuiPisyl3pqcYITpfwjJ18iM/9paxo8t4Bl8jboImpZD5LXu4+IR1y+MKVB8qLlqnyDHolOPa8U9FuJnOtqIaqC/UtZaWxrwrV+IaYpt4YDnygU04tdns/wXG7/ItQgOJs9ETEYmO9q9xgffcb7URiASgI4wOWVFXJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0w6cxpR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0w6cxpR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7E81F008A1
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 09:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789984291;
	bh=R9F7eCs5hlVe0XrQOYg+00J2R1c/rmdJwPU5ijIE2p4=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=J0w6cxpROIX6TE4J6DIgJu76eJyynKDstTTr+tfblPFjw2DpF0VReVyWoC8LMaHGO
	 r1/PyRV3pBHDz2rfJkTnrbV1korY59q41VfoZZ3HWiHwYt5oF0nV3BLMA1e2xLmXSB
	 mkU5CfqPdkI94cNEUd7p+fiS1Z1bEI0Up8CZzMk+QIgu/atRjd0/F6za9Gwv4ObiE/
	 ET3v/p9ig6JEpn4PNtqCU/y9HiM52wJQqzDPgQDLFz8e5klse5Dp+3S+3/ucCIDUnW
	 0bBn8c+UEBJA2Ika5GCuU4YTXyn9buv3OkjlGYZph77CSkHoka8ezapPxlziSh9+cG
	 RbipTfsze7Kow==
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b8c9954ccbso1200014e87.1
        for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 02:51:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwNul021Th/lucwecJdVmNrfCftIgkFIr2+2Qia3rDCXfgrweDPINoOk0zm8yZZrlcdgYx+Pk8PnUk=@vger.kernel.org
X-Gm-Message-State: AFuF++kuGwE2eVwTcFJq81keQfDu1cWizyHrMSXVD14/rGTKu6iALbr1
	pPvoAY+vLrRKY4yyFa9SPWY1YgUHdDWkzasaYvrnDL62Ep3aVI+QkYALTnnWRubazFcjfVx2ktb
	NprTXryRFzTOIhI625AnIdF9cECXDOdA3mm1qTbHXYg==
X-Received: by 2002:a05:6512:4023:b0:5b6:1a7c:fd96 with SMTP id
 2adb3069b0e04-5b8c197532bmr3127147e87.60.1789984290166; Mon, 21 Sep 2026
 02:51:30 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 21 Sep 2026 05:51:28 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 21 Sep 2026 05:51:28 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <CAMRc=MdHy6M9cY-ZqMXP_F6yLuVuipDkZwHoBF0D9W3A5VkOSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915-pci-m2-bt-rework-v1-0-3c7d9cf9c010@oss.qualcomm.com>
 <20260915-pci-m2-bt-rework-v1-3-3c7d9cf9c010@oss.qualcomm.com>
 <CAMRc=MdJgXDUb-Uac0TRB8u1WUpLng51C4yMH6iMEMoK56tQYA@mail.gmail.com>
 <p2qiwwig7ap74puja6mgnz37lofljhexiapmpp6y3xmwkhs2dn@v2mxawoivkn4> <CAMRc=MdHy6M9cY-ZqMXP_F6yLuVuipDkZwHoBF0D9W3A5VkOSQ@mail.gmail.com>
Date: Mon, 21 Sep 2026 05:51:28 -0400
X-Gmail-Original-Message-ID: <CAMRc=McfFtRi_kwPh6Dfz6MwGEy_Q7ojFmJ3ibJ6V4PiEDPetw@mail.gmail.com>
X-Gm-Features: AcwNN1XisqOT1G4P_pz-zd8sYeXwsQoqqLC2dtscBpTlrZOqZnjSykzHCvQdieE
Message-ID: <CAMRc=McfFtRi_kwPh6Dfz6MwGEy_Q7ojFmJ3ibJ6V4PiEDPetw@mail.gmail.com>
Subject: Re: [PATCH 3/5] power: sequencing: pcie-m2: Create auxiliary device
 for the M.2 BT interface
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pm@vger.kernel.org, Rahul Samana <rahul.samana@oss.qualcomm.com>, 
	Wei Deng <wei.deng@oss.qualcomm.com>, Loic Poulain <loic.poulain@oss.qualcomm.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Amitkumar Karwar <amitkumar.karwar@nxp.com>, 
	Neeraj Kale <neeraj.sanjaykale@nxp.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Manivannan Sadhasivam <mani@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Sep 2026 11:08:58 +0200, Bartosz Golaszewski <brgl@kernel.org> said:
> On Mon, 21 Sep 2026 09:58:27 +0200, Manivannan Sadhasivam <mani@kernel.org> said:
>> On Wed, Sep 16, 2026 at 04:19:16AM -0500, Bartosz Golaszewski wrote:
>>> On Tue, 15 Sep 2026 16:24:04 +0200, Manivannan Sadhasivam via B4 Relay
>>> <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> said:
>>> > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>>> >
>>> > Currently, the driver instantiates the BT interface of the WCN6855 and
>>> > WCN7850 combo modules by creating a devicetree node at runtime using an
>>> > of_changeset, with the compatible passed through the PCI ID table. But this
>>> > method of creating a devicetree node just for matching with the driver is
>>> > not recommended.
>>> >
>>> > So create an auxiliary device for the BT interface instead. The serdev
>>> > transport is still allocated here and handed over to the Bluetooth driver
>>> > through the auxiliary device, along with the power sequencing target used
>>> > to power up the controller. Also extend the provider match so that the
>>> > auxiliary device created for this connector is matched as its power
>>> > sequencing consumer.
>>> >
>>> > Since the runtime node creation is now gone, select AUXILIARY_BUS in
>>> > place of OF_DYNAMIC.
>>> >
>>> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>>> > ---
>>>
>>> That's some nice stuff, thanks for doing it!
>>>
>>> It looks like there's no build-time dependency on this, only run-time? Can I
>>> take it independently?
>>>
>>
>> Yeah sure!
>>
>
> Nevermind that, it still needs is_controllable().
>

Patch 3/5 also needs the header patch 1/5 adds, so we'll need a different
merge strategy here.

Bart
