Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0723515D3;
	Wed,  5 Aug 2026 14:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785939160; cv=none; b=lsU4oP7ONSnm/IcJ6H4kQx6tEp4q+4Lnp2N1znL2sifl3ehR6ygoutZeBefYAMKoZj2EasfwcMhOtiu1XhFMkweNa6OPRbF//qqDkt8IgVam/WLbn886Gk11up6aHulHsfMwnnw1aRYbPFmATMLZi4HtZ1Pnke6Tn5Mjph0RT0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785939160; c=relaxed/simple;
	bh=TmojK9GmOhWX1Kxwhz88EWENjch/+L/VsK+W+D3SyE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4E0Js6hT4y9sxw1P0P7TpqBJygb7IxsFOap3IwQLf1wCFsN45hKYotJ6guFxbgtQy4PkUF2aYNOVImOP7oxPEkUEyg/7EzyFRWRUa8MhgxzbAC4CEINDDp+Zveh4pzGSI3G9/iwB3I+RiVujbm9ZAbMlgmyD4dRF5wJ26CzGME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AE8N7vbd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AE8N7vbd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0BFF1F000E9;
	Wed,  5 Aug 2026 14:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785939158;
	bh=JA9VekJgeaROrWNtYHg4pEbVi13rJEbGDG50PEAl2y0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AE8N7vbdctmNq7g2nb9RL6O1Fcy9Ll2Qv4cisZGQSWijpExRfgrwta1XGg3QKqHif
	 8bk4RyB+4hCzfeM4SVkVkKeWmO+NdeLZ9VrhPzscBcYGa8u8c7F9NEesVrS85ERetX
	 ePpIDJK/UKleSE5vawWYaUXjKIi2OF2RNaM2I4W56NH7PlP99Sfecv9RFXvPsG9Cyp
	 0NmyCz4dVU3FfMaZT58H1Ck+Dg1MxgAp2ZDo0vATvo4AB+UDQRrcIeeBMksvawb9dD
	 5F4ok4xU/3PAzXAYNad0c+llYO3KP8LUPSeckH/wGsma4kdlXqgsVoHrdq/tyqvbhC
	 bcWyortTeR5Hw==
Date: Wed, 5 Aug 2026 16:12:16 +0200
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
Message-ID: <sewfntbhqtj2apfdi4ouan27artvj4lyxqizvinsvzltbofqu2@riuoo3fmczff>
References: <20260727-rb3-industrial-bt-uart-v2-1-2d100f30e202@oss.qualcomm.com>
 <20260731-first-righteous-bear-dd72ed@quoll>
 <712f8a14-d2a1-4a90-82f9-05cd694f2658@oss.qualcomm.com>
 <c1875dd6-fe3a-4a69-a6fd-b461c8fba6e4@kernel.org>
 <6d6465bb-47ac-464c-af4e-0ca72325705f@oss.qualcomm.com>
 <8a388310-d3cc-4d02-abb6-0eb98c24cfce@kernel.org>
 <4523441f-498a-4bbd-80f3-97a7a9206c00@oss.qualcomm.com>
 <6e0b9e79-ccd4-4689-9a6b-9b4fc556d5e4@kernel.org>
 <gfhlyvoefcsvtjuxfo75qeham272cc5g2r3npjenzs5esjifiy@ro7dtkpxwizk>
 <8ab6c26f-b648-447c-9fdd-f1424beb44f4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ab6c26f-b648-447c-9fdd-f1424beb44f4@kernel.org>

On Wed, Aug 05, 2026 at 02:33:51PM +0200, Krzysztof Kozlowski wrote:
> On 05/08/2026 14:09, Manivannan Sadhasivam wrote:
> > On Sat, Aug 01, 2026 at 05:49:53PM +0200, Krzysztof Kozlowski wrote:
> >> On 01/08/2026 17:31, Rahul Samana wrote:
> >>>
> >>>
> >>> On 01-08-2026 20:18, Krzysztof Kozlowski wrote:
> >>>> On 31/07/2026 17:51, Rahul Samana wrote:
> >>>>>
> >>>>>
> >>>>> On 31-07-2026 20:34, Krzysztof Kozlowski wrote:
> >>>>>> On 31/07/2026 16:45, Rahul Samana wrote:
> >>>>>>>
> >>>>>>>
> >>>>>>> On 31-07-2026 15:16, Krzysztof Kozlowski wrote:
> >>>>>>>> On Mon, Jul 27, 2026 at 09:15:01PM +0530, Rahul Samana wrote:
> >>>>>>>>> QCC2072 can be used on M.2 E-key cards where the card power resources are
> >>>>>>>>> described by the pcie-m2-e-connector node. In that setup, the M.2 power
> >>>>>>>>> sequencing provider creates the Bluetooth serdev child after matching the
> >>>>>>>>> QCC2072 PCI function.
> >>>>>>>>>
> >>>>>>>>> Integrated non-M.2 designs need board-specific power resources. Document
> >>>>>>>>> only the compatible for now and leave those properties to be added with
> >>>>>>>>> matching driver support.
> >>>>>>>>>
> >>>>>>>>> Document the qcom,qcc2072-bt compatible used for QCC2072 Bluetooth
> >>>>>>>>> controllers connected over UART.
> >>>>>>>>>
> >>>>>>>>> Signed-off-by: Rahul Samana <rahul.samana@oss.qualcomm.com>
> >>>>>>>>
> >>>>>>>> NAK, exactly same comments as before.
> >>>>>>>>
> >>>>>>>> Nothing got improved, although what is weird - original SoB is gone, so
> >>>>>>>> this is legally dubious work.
> >>>>>>>>
> >>>>>>>> Best regards,
> >>>>>>>> Krzysztof
> >>>>>>>>
> >>>>>>>
> >>>>>>> Hi Krzysztof,
> >>>>>>>
> >>>>>>> Thanks for the review.
> >>>>>>>
> >>>>>>> For the binding contents, I tried to capture the current scope in the binding
> >>>>>>> description itself. This series supports QCC2072 only as an M.2 E-key card,
> >>>>>>> where the card power resources are described by the pcie-m2-e-connector node
> >>>>>>> and the M.2 pwrseq provider creates the Bluetooth serdev child.
> >>>>>>>
> >>>>>>> The binding also says:
> >>>>>>>
> >>>>>>>   Integrated non-M.2 designs require board-specific power resources. Those
> >>>>>>>   properties, together with a static devicetree example, should be added when
> >>>>>>>   integrated non-M.2 support is added.
> >>>>>>
> >>>>>> Bindings must be complete and your driver support is irrelevant here.
> >>>>>>
> >>>>>> If you claim this is a PCI device thus you do not need any resources,
> >>>>>> then the binding is not needed either. PCI devices are enumerable. And
> >>>>>> to prove it: look at your DTS. Do you see qcom,qcc2072-bt being used? No.
> >>>>>>
> >>>>>>>
> >>>>>>> We do not currently have an integrated non-M.2 QCC2072 design, so I do not
> >>>>>>> have board-specific regulator supplies to document for that topology.
> >>>>>>>
> >>>>>>> Could you please suggest how you would prefer this binding to be handled for
> >>>>>>> the current M.2-only use case? 
> >>>>>>
> >>>>>> Drop the binding, you do not need it.
> >>>>>>
> >>>>>> Anyway the problem is that more comments were ignored.
> >>>>>>
> >>>>>
> >>>>> Hi Krzysztof,
> >>>>>
> >>>>> Just to clarify the reason for adding this binding in v2: 
> >>>>> v1 did not add a binding because this series only targets the M.2 use case.
> >>>>>
> >>>>> I added the minimal binding in v2 because checkpatch reported
> >>>>> qcom,qcc2072-bt as an undocumented compatible, and I interpreted the request
> >>>>> to fix the checkpatch warnings as requiring this compatible to be documented.
> >>>>> I also had the earlier feedback in mind, where the indirect
> >>>>> qcom,qcc2072-bt compatible was pushed back because it was undocumented:
> >>>>>
> >>>>> https://lore.kernel.org/all/20260703-eliza_evk-v1-3-7624440bd76d@oss.qualcomm.com/
> >>>>>
> >>>>> Based on your clarification here, I will drop the binding patch in v3 and
> >>>>> keep qcom,qcc2072-bt only as the pwrseq-created child compatible for this
> >>>>> M.2 case.
> >>>>
> >>>> My previous statement is also valid, please read entire threads.
> >>>>
> >>>> You cannot have undocumented qcom,qcc2072-bt.
> >>>>
> >>>> I ask you to drop both, because they are not needed. But feel free to
> >>>> prove me wrong, see my first paragraph in the previous reply.
> >>>>
> >>>>
> >>> The PCIe M.2 power sequencing driver, pwrseq-pcie-m2.c, uses
> >>> pwrseq_m2_pci_ids to translate the enumerated PCI function into the
> >>> Bluetooth compatible used for the generated serdev child.
> >>>
> >>> For example, WCN7850 maps PCI ID 17cb:1107 to qcom,wcn7850-bt, then hci_qca
> >>> matches that compatible to select qca_soc_data_wcn7850.
> >>>
> >>> For QCC2072, pwrseq-pcie-m2.c matches PCI ID 17cb:1112 and creates the
> >>> generated Bluetooth serdev child with compatible "qcom,qcc2072-bt". The
> >>> hci_qca driver then matches "qcom,qcc2072-bt" and uses qca_soc_data_qcc2072
> >>> as the controller-specific data.
> >>
> >> The purpose of Devicetree is not to describe Linux internal driver
> >> matching. Do not use compatibles for that.
> >>
> >>
> >>>
> >>> That match data is needed by hci_qca to select the QCC2072 soc_type,
> >>> firmware/NVM naming, calibration handling, and capabilities. Without some
> >>> identity being passed from the PCI match to the generated serdev child,
> >>> hci_qca cannot distinguish QCC2072 from the other Qualcomm UART Bluetooth
> >>> controllers on this path.
> >>>
> >>> Please correct me if I misunderstood the concern or if you are asking for
> >>> this identity to be passed from pwrseq-pcie-m2.c to hci_qca through a
> >>> different mechanism.
> >>>
> >>> I can drop the binding patch, but unless there is a preferred alternative
> >>> mechanism, I think we still need the pwrseq-pcie-m2 QCC2072 PCI ID support
> >>> from patch 3 so the power sequencing driver can pass the QCC2072 identity
> >>> into hci_qca through the generated serdev child:
> >>
> >> You have plenty of options, starting from what is very common already -
> >> driver name used by MFD or aux devices.
> >>
> > 
> > It is not just a driver matching problem, but ensuring that we properly describe
> > the BT device in DT. Since the BT interface of the M.2 device is not
> 
> This device does not exist in DT. This is the problem which started my
> entire investigation and above email.
> 
> I am happy to see proofs of it existing in DTS.
> 
> My proof:
> 1. copy-paste the compatible (qcom,qcc2072-bt) from the binding.
> 2. Open each DTS patch and look for that compatible: no results.
> 

You are right that this compatible didn't exist in DT and I never claimed that
it does.

> 
> 
> > discoverable, we are currently using the PCIe IDs of the M.2 device to create
> > the BT node dynamically under UART node using OF_DYNAMIC as proposed in this
> > patch which got merged already [1]. Then we also create the serdev device and
> > allow the existing BT hci_qca driver to probe and make use of the created DT
> > node.
> 
> Your Linux drivers are not supposed to create internal OF for regular
> DT. Please drop that patch. I do not get why that patch was merged
> without any DT approval.
> 

Both Rob, you and devicetree lists were CCed to the series and there were
reviews from Rob for multiple patches in that series too. So I interpreted his
absence of reviews on other patches in the series as silent Acks.

> DT is not representation of internal device driver instantiation mechanism.
> 

Here, the driver is just creating compatible for a real device. What difference
does it make if the BT node was defined statically in the DT vs created
dynamically? Both nodes do represent a real BT device, not driver's own
representation. And by the time the node was created, the device is physically
attached to the system.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
