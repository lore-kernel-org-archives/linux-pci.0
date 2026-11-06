Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.24
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793989819;
	b=c6allUZnfyHIsngpSmKky+IMcrC+CRTn6f7///OUM5CHCuyFbYWRjdpeP+QlZ93O5+Jd
	 DYHW6ez66gQSHPOCTdWzuqjTkPALAnMDspStAa7moJ/cz9OMuutzHV1pN+ozLo0z47ZPd
	 xU0KgiDUssIhROw/enZCwsz/Cz4W5sc3KrKr4Oz76woEuR6PVyy6P3zwGv4vqKCskHyY1
	 HTeo2CJPKzgRKkHxsVt9OoWxgehe+E5NB3DzYkr5Vx/GgWKhk3I749P+v96vdWEbGhtil
	 vz0FTwfNu7TIjP9CeBoC7mcYaCDsy6SzmrrhhyqCSzIutWmL6RV1djLwiqElm1MmRzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989819;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=XeCWC0we14RDO6PsuYQS3ZgZBwQlD8qMOkqFFl7IHZY=;
	b=2f9JErzuQEP3hURKCCVlICEDooSDr2d3Nkp4e95v2w057cQ1mLmltvK6S+QJwwD7jq7N
	 sxrrm/r7AQlgkqAmQ5PsOzLXuSnZ/CO7V7eoq0Fspuyi/4JhPp2Ix54/9Pjm0oFd2ISU+
	 LbCq9PBTQtBiPCscAYIFKJjkGq9zIu7AxYT0jaYljyPogQuxI71UtHn7BXZmUscZQ+BfT
	 6hzZLVU2a/6UE39+3PAv7giVn9RKZobQeK+szlybDsaAGNSrRaPGmA1ZgWFqIs9s4Z8+W
	 w1VI+AwdpSddKn5GTHcnruVBYK4jbBPEgd6sAUY26+K5+UipRqeLkcOBvyCoEHZ7S6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oldschoolsolutions.biz;
	spf=pass smtp.mailfrom=oldschoolsolutions.biz;
	dkim=pass header.d=oldschoolsolutions.biz header.i=jens.glathe@oldschoolsolutions.biz header.a=rsa-sha256 header.s=s1-ionos header.b=LK1bBsOY;
	arc=none smtp.remote-ip=212.227.17.24
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21ED606A331
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 18:30:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C21ED606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oldschoolsolutions.biz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oldschoolsolutions.biz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oldschoolsolutions.biz header.i=jens.glathe@oldschoolsolutions.biz header.a=rsa-sha256 header.s=s1-ionos header.b=LK1bBsOY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oldschoolsolutions.biz; s=s1-ionos; t=1793989806; x=1794594606;
	i=jens.glathe@oldschoolsolutions.biz;
	bh=XeCWC0we14RDO6PsuYQS3ZgZBwQlD8qMOkqFFl7IHZY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=LK1bBsOYu4BGhHHExf6Yb7mxO64hLTLN1qQSuTwB4Alx5MS3hL2QA+lyjuY3DQvY
	 yGTTH4icF4ObAOjt74OtjmrfabyRDh2hjS9IhoLbCyw0eErvJKGVwZ9FWi2beD6I3
	 ECUqqVhkeDz0nxu8X5tIKUQBOmQ4w80M7ionKqX6fUfykIuHFovi5EQvkm1AUzZ6E
	 QTCcz9VtyYG0R51uCyL8jACaqE4/3PyBkQE76ixpHHNWJCpJAjLL6bKtRjTdKt8zg
	 oYA/4Yh4cxH929glho3wOSOrvJd8OMYqpNaENTQnRBk/7Bdon7yDfubY9//6E/RAS
	 OmmYam+IZv+FxMRH+Q==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue108
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MDQmW-1xEypU2o1m-00Fcgd; Fri, 06
 Nov 2026 19:30:06 +0100
Message-ID: <1c9b4722-0466-4c74-ac86-4d0f61c350a9@oldschoolsolutions.biz>
Date: Fri, 6 Nov 2026 19:30:06 +0100
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] power: sequencing: pcie-m2: stop requiring subsystem
 IDs for WCN6855/WCN7850
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
References: <20261106-pwrseq-bt-subsystem-v1-1-11fb09f63c93@oldschoolsolutions.biz>
 <sashiko-outbox-201312@kernel.org>
Content-Language: en-US
From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
In-Reply-To: <sashiko-outbox-201312@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lSJgv4tmDjZoe6kN573hLoabpWwG4Q52LPY+pON8+mtV0OZBQWi
 53fS+oIc6t3KMqxstnrxtw1V1V8SkjFUotXWNhrB0xY+A2suc1eJXSGl3YT8NT7FQ78NI9x
 LlvNq8J4S5KO30PPt/WKzQAmagyURguD1y/GU4AS0ZbinXiTMaKqR/APDZGLAkIVwussYgN
 WCkJRzSZTe4hO0pnVnaug==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CvfCFQMXMbI=;Ynf9fkQgEG/QDEC9oTRKvuN2mbB
 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

Hi sashiko-bot,

On 11/6/26 12:26, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [High] pwrseq: pcie-m2: bare PCI_DEVICE() creates bogus serdev on
>    USB-BT cards
> --
>
> commit 651d16502b81077112cba212f5fb84dc03306321
> Author: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
>
> power: sequencing: pcie-m2: stop requiring subsystem IDs for WCN6855/WCN=
7850
>
> This commit replaces the subsystem-specific PCI_DEVICE_SUB() entries for
> Qualcomm WCN6855 (0x1103) and WCN7850 (0x1107) in pwrseq_m2_pci_ids[] wi=
th
> bare PCI_DEVICE() entries.
>
>> diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/=
sequencing/pwrseq-pcie-m2.c
>> index 56c5d51293c10..72c721149dfae 100644
>> --- a/drivers/power/sequencing/pwrseq-pcie-m2.c
>> +++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
>> @@ -217,15 +217,9 @@ static const struct pci_device_id pwrseq_m2_pci_id=
s[] =3D {
>>   	  .driver_data =3D (kernel_ulong_t)"nxp,88w8987-bt" },
>>   	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x1103, PCI_VENDOR_ID_QCOM, 0x0=
108),
>>   	  .driver_data =3D (kernel_ulong_t)"qcom,qca2066-bt" },
>> -	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x1103, PCI_VENDOR_ID_FOXCONN, 0=
xe105),
>> +	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1103),
>>   	  .driver_data =3D (kernel_ulong_t)"qcom,wcn6855-bt" },
>> -	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x1103, PCI_VENDOR_ID_QCOM, 0x33=
7e),
>> -	  .driver_data =3D (kernel_ulong_t)"qcom,wcn6855-bt" },
>> -	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x1107, PCI_VENDOR_ID_QCOM, 0x33=
7c),
>> -	  .driver_data =3D (kernel_ulong_t)"qcom,wcn7850-bt" },
>> -	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x1107, PCI_VENDOR_ID_LENOVO, 0x=
e0e9),
>> -	  .driver_data =3D (kernel_ulong_t)"qcom,wcn7850-bt" },
>> -	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x1107, PCI_VENDOR_ID_FOXCONN, 0=
xe0ee),
>> +	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1107),
>>   	  .driver_data =3D (kernel_ulong_t)"qcom,wcn7850-bt" },
>>   	{ } /* Sentinel */
>>   };
> [Severity: High]
> Won't matching bare 0x1103 and 0x1107 device IDs reintroduce the regress=
ion
> fixed by a39ac4651e3b ("power: sequencing: pcie-m2: Match WCN6855 and
> WCN7851 UART BT variants by subdevice ID") whenever a USB-BT M.2 card is
> plugged into a socketed M.2 Key E slot?
>
> The pcie-m2-e-connector node describes the physical M.2 slot wiring on t=
he
> host board, not the card installed in it.  Boards with a general-purpose=
 M.2
> Key E socket (such as arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts) wire t=
he
> SoC UART to the slot and define port@3 unconditionally in their static D=
T.
>
> When a USB-BT WCN6855 or WCN7850/WCN7851 card is inserted into such a sl=
ot,
> pwrseq_pcie_m2_create_serdev() -> pwrseq_pcie_m2_create_serdev_one() see=
s
> port@3 on ctx->dev and matches 0x1103 or 0x1107 in pwrseq_m2_pci_ids[]. =
 It
> then creates a bogus bluetooth OF node and UART serdev device, causing
> hci_qca to bind alongside btusb and fail with -ETIMEDOUT in qca_setup() =
on
> the unconnected UART lines.
>
> Also, the commit message notes that Lenovo T14s Gen 6 (17aa:e0e9) is mis=
sing
> from the table, but 58a003302481 ("power: sequencing: pcie-m2: Add Lenov=
o
> ThinkPad T14s gen6 WCN7850 subsystem PCI ids") already added that entry
> above.
Well. It was missing upstream when I made the experience on my T14s G6.=20
Having a whitelist for every subsystem that is allowed in such a generic=
=20
driver is not the best design decision, IMO.
I took another look, this driver is loaded when it is a compatible in a=20
device tree. Usually this means the hardware got described, and you can=20
draw conclusions from the device tree on what is supported. For the=20
conflicting case, the device tree would need to describe the USB and the=
=20
serial port on the e-key connector. When you have a connector wired up=20
this way, the driver would need directions on what to choose, for=20
instance by providing the subsystem IDs as base for a decision. These=20
are the special cases, though. For most boards describing the uart on=20
the connector would suffice to choose the right, mostly generic driver=20
for WCN6855 and WCN7850. So it would be better to have the driver detect=
=20
the "both ports are defined in the dt" case and=C2=A0 not create a serdev:

static bool pwrseq_pcie_m2_bt_ambiguous(struct device *dev)
{
 =C2=A0 =C2=A0 bool has_usb=C2=A0 =3D pwrseq_pcie_m2_check_remote_node(dev=
, 2, 0, "usb");
 =C2=A0 =C2=A0 bool has_uart =3D pwrseq_pcie_m2_check_remote_node(dev, 3, =
0, "serial");

 =C2=A0 =C2=A0 return has_usb && has_uart;
}

Then in the create path (and before registering the notifier):

if (pwrseq_pcie_m2_bt_ambiguous(ctx->dev)) { dev_info(ctx->dev,=20
"connector describes both USB and UART BT; refusing automatic serdev=20
creation\n"); return 0; }

For the rare board that is wired for both and still wants automatic=20
selection, an explicit bt-interface property (or a fall-back to the=20
subsystem-ID table) can be added later. That keeps the subsystem catalog=
=20
out of the common path.

Using subsystem IDs for the ambiguous case is possible, but it does=20
require separate driver data (or at least separate table entries) for=20
each known UART-BT SKU, which is exactly the growing whitelist I am=20
trying to avoid for the normal case. The port check handles the common=20
case without it; the whitelist only becomes necessary again if we want=20
zero-DT-change behaviour on dual-wired sockets.

with best regards

Jens

