Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0D346AA6B;
	Wed,  5 Aug 2026 12:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785931798; cv=none; b=HAPqthJmsnFOF4MsaP6+wn4TZH/d3uIUkP2WGwoXiczDIZXnT1JDjCVbx9f6NsYpl/tSNEh+5JMMhwfBj161l9z0YRNbmilfX/5wvnB8YxpWp0M8i0OraTZxCiABIm7B+C7MuDXnHLTvzkc4TxARQj8oB1Yo94U9OuqMkUumA1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785931798; c=relaxed/simple;
	bh=TggrNnVWCqegCmN+qnDd/lbIP1Jj3+XKWs97+DYbKPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bw1fn9g45XY+lsN0JmXl1v9y9YF2scLiHr8FllriwSgC3CLM//j7b5jSXNDkvr21PzL/hocWUjWwnGoRPnlcmSEaHUOo89+hpZITytZK0/LmXyi7zt3rjqS1gYUrjSFtEN7frH6a7tQdoQhJY4ZRLQAdnbfeChS18U21xcGGxqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmgmVdXL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmgmVdXL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B812E1F00ADF;
	Wed,  5 Aug 2026 12:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785931782;
	bh=m0PaxOSw/nL8V3kNaa8yda1zYqp+YjlKb11BL70wWgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NmgmVdXLynMNJGUSa1OW3TrxVgbQUwB/CvtaNkKCfTjSb/JQZUT+eAKxLd51m4Xk7
	 IDUqn1JKE4UlKrbnRZwxyUez2KVUO6Q22GlpVVsalRa5WMtyR5t6K2vpZtTP/rgQyL
	 D3p1dtF1RTzlbkmkYTA0sSi75Z8us+pBFYFouiT9znrAL1fXFNMRa/Y1yXzAnZayz2
	 QMlMh949vffxY/hHXwQLefJrV1xK6Ii3QC2K4y0W68lL538bA5orPr+8hdX6UXBCya
	 SXrBfnyCkEd7N70cHwVox/TrvkUZjXEqZ9H8zpyOVM6zyx9x9R9twP2ANxQskL5nDO
	 w4k6o8m/pNzFg==
Date: Wed, 5 Aug 2026 14:09:21 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rahul Samana <rahul.samana@oss.qualcomm.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pm@vger.kernel.org, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com, 
	quic_anubhavg@quicinc.com
Subject: Re: [PATCH v2 1/6] dt-bindings: bluetooth: qca: add QCC2072
Message-ID: <gfhlyvoefcsvtjuxfo75qeham272cc5g2r3npjenzs5esjifiy@ro7dtkpxwizk>
References: <20260727-rb3-industrial-bt-uart-v2-0-2d100f30e202@oss.qualcomm.com>
 <20260727-rb3-industrial-bt-uart-v2-1-2d100f30e202@oss.qualcomm.com>
 <20260731-first-righteous-bear-dd72ed@quoll>
 <712f8a14-d2a1-4a90-82f9-05cd694f2658@oss.qualcomm.com>
 <c1875dd6-fe3a-4a69-a6fd-b461c8fba6e4@kernel.org>
 <6d6465bb-47ac-464c-af4e-0ca72325705f@oss.qualcomm.com>
 <8a388310-d3cc-4d02-abb6-0eb98c24cfce@kernel.org>
 <4523441f-498a-4bbd-80f3-97a7a9206c00@oss.qualcomm.com>
 <6e0b9e79-ccd4-4689-9a6b-9b4fc556d5e4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6e0b9e79-ccd4-4689-9a6b-9b4fc556d5e4@kernel.org>

On Sat, Aug 01, 2026 at 05:49:53PM +0200, Krzysztof Kozlowski wrote:
> On 01/08/2026 17:31, Rahul Samana wrote:
> > 
> > 
> > On 01-08-2026 20:18, Krzysztof Kozlowski wrote:
> >> On 31/07/2026 17:51, Rahul Samana wrote:
> >>>
> >>>
> >>> On 31-07-2026 20:34, Krzysztof Kozlowski wrote:
> >>>> On 31/07/2026 16:45, Rahul Samana wrote:
> >>>>>
> >>>>>
> >>>>> On 31-07-2026 15:16, Krzysztof Kozlowski wrote:
> >>>>>> On Mon, Jul 27, 2026 at 09:15:01PM +0530, Rahul Samana wrote:
> >>>>>>> QCC2072 can be used on M.2 E-key cards where the card power resources are
> >>>>>>> described by the pcie-m2-e-connector node. In that setup, the M.2 power
> >>>>>>> sequencing provider creates the Bluetooth serdev child after matching the
> >>>>>>> QCC2072 PCI function.
> >>>>>>>
> >>>>>>> Integrated non-M.2 designs need board-specific power resources. Document
> >>>>>>> only the compatible for now and leave those properties to be added with
> >>>>>>> matching driver support.
> >>>>>>>
> >>>>>>> Document the qcom,qcc2072-bt compatible used for QCC2072 Bluetooth
> >>>>>>> controllers connected over UART.
> >>>>>>>
> >>>>>>> Signed-off-by: Rahul Samana <rahul.samana@oss.qualcomm.com>
> >>>>>>
> >>>>>> NAK, exactly same comments as before.
> >>>>>>
> >>>>>> Nothing got improved, although what is weird - original SoB is gone, so
> >>>>>> this is legally dubious work.
> >>>>>>
> >>>>>> Best regards,
> >>>>>> Krzysztof
> >>>>>>
> >>>>>
> >>>>> Hi Krzysztof,
> >>>>>
> >>>>> Thanks for the review.
> >>>>>
> >>>>> For the binding contents, I tried to capture the current scope in the binding
> >>>>> description itself. This series supports QCC2072 only as an M.2 E-key card,
> >>>>> where the card power resources are described by the pcie-m2-e-connector node
> >>>>> and the M.2 pwrseq provider creates the Bluetooth serdev child.
> >>>>>
> >>>>> The binding also says:
> >>>>>
> >>>>>   Integrated non-M.2 designs require board-specific power resources. Those
> >>>>>   properties, together with a static devicetree example, should be added when
> >>>>>   integrated non-M.2 support is added.
> >>>>
> >>>> Bindings must be complete and your driver support is irrelevant here.
> >>>>
> >>>> If you claim this is a PCI device thus you do not need any resources,
> >>>> then the binding is not needed either. PCI devices are enumerable. And
> >>>> to prove it: look at your DTS. Do you see qcom,qcc2072-bt being used? No.
> >>>>
> >>>>>
> >>>>> We do not currently have an integrated non-M.2 QCC2072 design, so I do not
> >>>>> have board-specific regulator supplies to document for that topology.
> >>>>>
> >>>>> Could you please suggest how you would prefer this binding to be handled for
> >>>>> the current M.2-only use case? 
> >>>>
> >>>> Drop the binding, you do not need it.
> >>>>
> >>>> Anyway the problem is that more comments were ignored.
> >>>>
> >>>
> >>> Hi Krzysztof,
> >>>
> >>> Just to clarify the reason for adding this binding in v2: 
> >>> v1 did not add a binding because this series only targets the M.2 use case.
> >>>
> >>> I added the minimal binding in v2 because checkpatch reported
> >>> qcom,qcc2072-bt as an undocumented compatible, and I interpreted the request
> >>> to fix the checkpatch warnings as requiring this compatible to be documented.
> >>> I also had the earlier feedback in mind, where the indirect
> >>> qcom,qcc2072-bt compatible was pushed back because it was undocumented:
> >>>
> >>> https://lore.kernel.org/all/20260703-eliza_evk-v1-3-7624440bd76d@oss.qualcomm.com/
> >>>
> >>> Based on your clarification here, I will drop the binding patch in v3 and
> >>> keep qcom,qcc2072-bt only as the pwrseq-created child compatible for this
> >>> M.2 case.
> >>
> >> My previous statement is also valid, please read entire threads.
> >>
> >> You cannot have undocumented qcom,qcc2072-bt.
> >>
> >> I ask you to drop both, because they are not needed. But feel free to
> >> prove me wrong, see my first paragraph in the previous reply.
> >>
> >>
> > The PCIe M.2 power sequencing driver, pwrseq-pcie-m2.c, uses
> > pwrseq_m2_pci_ids to translate the enumerated PCI function into the
> > Bluetooth compatible used for the generated serdev child.
> > 
> > For example, WCN7850 maps PCI ID 17cb:1107 to qcom,wcn7850-bt, then hci_qca
> > matches that compatible to select qca_soc_data_wcn7850.
> > 
> > For QCC2072, pwrseq-pcie-m2.c matches PCI ID 17cb:1112 and creates the
> > generated Bluetooth serdev child with compatible "qcom,qcc2072-bt". The
> > hci_qca driver then matches "qcom,qcc2072-bt" and uses qca_soc_data_qcc2072
> > as the controller-specific data.
> 
> The purpose of Devicetree is not to describe Linux internal driver
> matching. Do not use compatibles for that.
> 
> 
> > 
> > That match data is needed by hci_qca to select the QCC2072 soc_type,
> > firmware/NVM naming, calibration handling, and capabilities. Without some
> > identity being passed from the PCI match to the generated serdev child,
> > hci_qca cannot distinguish QCC2072 from the other Qualcomm UART Bluetooth
> > controllers on this path.
> > 
> > Please correct me if I misunderstood the concern or if you are asking for
> > this identity to be passed from pwrseq-pcie-m2.c to hci_qca through a
> > different mechanism.
> > 
> > I can drop the binding patch, but unless there is a preferred alternative
> > mechanism, I think we still need the pwrseq-pcie-m2 QCC2072 PCI ID support
> > from patch 3 so the power sequencing driver can pass the QCC2072 identity
> > into hci_qca through the generated serdev child:
> 
> You have plenty of options, starting from what is very common already -
> driver name used by MFD or aux devices.
> 

It is not just a driver matching problem, but ensuring that we properly describe
the BT device in DT. Since the BT interface of the M.2 device is not
discoverable, we are currently using the PCIe IDs of the M.2 device to create
the BT node dynamically under UART node using OF_DYNAMIC as proposed in this
patch which got merged already [1]. Then we also create the serdev device and
allow the existing BT hci_qca driver to probe and make use of the created DT
node.

Since each BT device is unique, the compatible used in the dynamic node needs to
be documented in the binding. But there is no need to describe any supplies or
BT_EN GPIOs since they are already part of the M.2 binding.

- Mani

[1] https://lore.kernel.org/all/20260326-pci-m2-e-v7-8-43324a7866e6@oss.qualcomm.com/

-- 
மணிவண்ணன் சதாசிவம்
