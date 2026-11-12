Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.72.192.73
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794507211;
	b=bw+VWmMvqSF8k0FTFL/CNggjG8DQIl/sSYrBoqE39rjdy4fB7MA1A/15pT8EwMSbpr9K
	 ByDSCBjzqruDDaXMkaaV54XLMOY/mC8IBD1hlUZ2NPkdwfHcW7TOTI5itHalON3AdTFR2
	 rpF4rnQyY1wixNjef2wQLqrTtgPWTdOHfUhuQ7cW2nK1nSpyajfhO2lTWQssK3NzSwipt
	 mfWInV6FL2RoSPozx57BvmwlJwiGy9ajKy6o6C8I2IrJ/1U1t7AlLfOmo+j7pCjeSLOUg
	 tNQwFwlnolEFe3BSvMg6FjElgwek8ZkSL99jxGc1fNklHIQEttPQkNeHAGANbdDqrtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794507211;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=f6og1mflS+f6FYGDq7VgPPhrrQtK0lH/JcILM0m+pus=;
	b=hsBl9tyIDlPZakItJzZI6uljenGgeOJ7rSsU4Lqq9a2lxK4xcgJ3OfLrjf21Ys4Cr1jT
	 j/iWLeI8J7bVkf5W6CO2PcMuN2NBC75L6ZZXgJoZKQ8Za5dA0py/7MvkKWGSgacX72JoO
	 ojpJDHgLereyEzXj9JrBYhROyZeSXpF0FnLtJqHlI6oUFESYwB3vGXg1Ac4BOEZAmlUvh
	 k51cDjSOciZxodBWWFkz5b2TJAsHmIU2Cn4vnbvtTp314khEi9ZADaf7kgLjrePkuFUXp
	 veN2mgNaobWhVc6BnaFa5tbFP3TR9fh/+ro4C4OJREi8ZadpYSyiUy4LFxoGHKt2LpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oldschoolsolutions.biz;
	spf=pass smtp.mailfrom=oldschoolsolutions.biz;
	dkim=pass header.d=oldschoolsolutions.biz header.i=jens.glathe@oldschoolsolutions.biz header.a=rsa-sha256 header.s=s1-ionos header.b=uOcuWN0I;
	arc=none smtp.remote-ip=217.72.192.73
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B344C606A31C
	for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 18:13:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B344C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oldschoolsolutions.biz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oldschoolsolutions.biz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oldschoolsolutions.biz header.i=jens.glathe@oldschoolsolutions.biz header.a=rsa-sha256 header.s=s1-ionos header.b=uOcuWN0I
DKIM2-Signature:  i=1; m=1; t=1794507208;
 mf=PGplbnMuZ2xhdGhlQG9sZHNjaG9vbHNvbHV0aW9ucy5iaXo+;
 rt=PGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc+;
 d=oldschoolsolutions.biz;
 s=s1-ionos:rsa-sha256:hC7mF0vedF/uC4rijJgyhs34smFG
   iCm+QHLUnsFVz8tjfMmaxwiW1LwlCtY7EQ6hZjaOEedpgbxpqvjyzWjYwvwM1ntbhITUALQDk1R
   LhU1sCgRXssU+cX4P6kliDsqBSAnF0EcZ0rEYnI1Bc9iNIlzGcU2fZjApzIQ9Qkl0MP0EXK2cer
   z4j0feQk6iRFfvwrkVjA7lTOaLXqMlDkTIW/+m/z0kFpcVj5RnV9hSZ5F2OQRJN+9H1dcbg/87O
   1G1ZXW5h4WEZhmqA7FgDeXAcShCMD073sP9QQgu+0I22+8fX/68jqz1u/b+VoAZCWsbAGmoGFnW
   dRndyV2fRw9ilw==;
Message-Instance:  m=1;
 h=sha256:
   wUhEu6DoOLgqCXZ1lPyNke6Y8gSJO/Fwf8HkxCOEL+A=:
   3YhHG6K7Vdob8qJmLIxB88n4Ch9BrCx0c8Fi/UvgWU8=,
  sha512:
   jSv4wDsBifXmGvgNtjwzmsbvh/YcNqnzr/5TkpU17/l2cCgIy9we4UJGcu0t6sQVXbOhaoyDxHjFo0eh4BhcRQ==:
   CmrZ3O+C4nkNnLmbjYrc0wndDX3QDPFk6nUdSZPtC0YzFLx0bLcHgPsqTu6KefDGKSXpfZXKlwysWEmCrkNt+A==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oldschoolsolutions.biz; s=s1-ionos; t=1794507190; x=1795111990;
	i=jens.glathe@oldschoolsolutions.biz;
	bh=f6og1mflS+f6FYGDq7VgPPhrrQtK0lH/JcILM0m+pus=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=uOcuWN0Il7EeWeVaNCJ6qckMwBxf0iVsWUnQYH+djSmMufXmeRUi4JtyGWqIZM/9
	 gVJvefqA+uJES/q9QgLgZDICIU/0IA7OW1RmZGnsU4oitSnhQyfi+xEK9IygvJtiT
	 0zgcJv4Xju7dd6V/emk6ap7hYG1XaX8tHj+bgl/BHQjYhVaeuCBCb4yDFyQT6XT1V
	 o32otsB8zXJHt3ScFIX3xVUkWOLqALS65IfPhih8w7pK79LDqTHbxyKlosdSqjF3a
	 xvroSkBhzMje+ITxihnjxJozzPjQ01t925R0DGkzznQwnrEGYnn/g2Ci2xuQn9Zls
	 CpOj7i7kv/1zHFOILQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue106
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1M6EKU-1xPOV33xPs-005qEi; Thu, 12
 Nov 2026 19:13:10 +0100
Message-ID: <a2ab7524-6dfd-44ed-84f5-305e6f610719@oldschoolsolutions.biz>
Date: Thu, 12 Nov 2026 19:13:09 +0100
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
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, linux-pci@vger.kernel.org
References: <20261106-pwrseq-bt-subsystem-v1-1-11fb09f63c93@oldschoolsolutions.biz>
 <sashiko-outbox-201312@kernel.org>
 <1c9b4722-0466-4c74-ac86-4d0f61c350a9@oldschoolsolutions.biz>
 <avXPkTkW2ZE_fngY@debian>
Content-Language: en-US
From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
In-Reply-To: <avXPkTkW2ZE_fngY@debian>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YnXzGOmC/8Bsq+OW1YJ/+ORBf0y6Cb+wLasX2/XAVilS+SxQwIU
 v1VpkRyc6Zsshn9OAZ189ZzxCA7TOg0l6ZScoazVfBzdRmnagFIVoHOfuCPD0MO7J2sbIBp
 DDpLp6Cqw8rM56xThlBCqZReZt3mrNIM1q1rvt5mC0EGVtYOvY92zgfJvBd0lfvAAGEJ5He
 1QP+VSk4IhSD43uWPWDfg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:v3hc+oWL56c=;+R27gY0DnUcrvAv7FJWIXxzcy2A
 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

Hi Mani,

On 11/12/26 15:43, Manivannan Sadhasivam wrote:
> On Fri, Nov 06, 2026 at 07:30:06PM +0100, Jens Glathe wrote:
[...]
>> I took another look, this driver is loaded when it is a compatible in a
>> device tree. Usually this means the hardware got described, and you can=
 draw
>> conclusions from the device tree on what is supported. For the conflict=
ing
>> case, the device tree would need to describe the USB and the serial por=
t on
>> the e-key connector. When you have a connector wired up this way, the d=
river
>> would need directions on what to choose, for instance by providing the
>> subsystem IDs as base for a decision. These are the special cases, thou=
gh.
>> For most boards describing the uart on the connector would suffice to c=
hoose
>> the right, mostly generic driver for WCN6855 and WCN7850. So it would b=
e
>> better to have the driver detect the "both ports are defined in the dt"=
 case
>> and=C2=A0 not create a serdev:
>>
>> static bool pwrseq_pcie_m2_bt_ambiguous(struct device *dev)
>> {
>>  =C2=A0 =C2=A0 bool has_usb=C2=A0 =3D pwrseq_pcie_m2_check_remote_node(=
dev, 2, 0, "usb");
>>  =C2=A0 =C2=A0 bool has_uart =3D pwrseq_pcie_m2_check_remote_node(dev, =
3, 0, "serial");
>>
>>  =C2=A0 =C2=A0 return has_usb && has_uart;
>> }
>>
> This is wrong. A generic slot can define both 'usb' and 'serial' endpoin=
t
> nodes and users can connect any key E cards to the slot. So having both =
nodes
> doesn't mean that the user is only going to connect BT-UART cards.
>
> While I agree with you that populating the ID table for each module is a=
 pain,
> we can't magically detect the card type before probing the device.
>
> - Mani

Of course it is :) Side note: the hamoa/purwa-iot-evk describes the m.2=20
port as having only the serdev, not the usb port. But usb_2 is connected=
=20
to it. So, this logic won't do a thing there, either. For me this more=20
or less sounds like a negative list, like... same device ID, but an USB=20
variant (subdevice ID) should lead to not creating a serdev. That list=20
is probably shorter(?). Anyway, its RFC. I was just a bit surprised that=
=20
my T14s BT got killed by the new powerseq driver.

with best regards

Jens

