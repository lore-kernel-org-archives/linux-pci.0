Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792963003;
	b=jB/MJAIl40hrf4XAgqeTRkNXn5rxRq77HrPVjPoEVebaYQ34BcIWUPMuU0PNj3RCQpER
	 ZuHZcJz8eSO9u3IBeF/o8RsczB0YIfn6leWyxNXdNaJjy05itnCXFvPftJABXdkUVZtzZ
	 +ilb40FEkAMccpJxfFdYZdOg+bVoLdrn4ZN5GC76XV9DuJ9z+5TFC/kkFoCzyG5Z9fUis
	 g99PIUgL2SCPbEx3yqG4F69r7pFmYORqOiJN36rHKUuHtGwOjSr/zRE3nErFLHQpMT5G3
	 Ck8QjRsALiYc0Nz49BKvaBWY3RHDIGT6NAt0eKGqOgsmj412GxkVTWmjva2uyQV1spw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792963003;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-MBO-RS-META:X-MBO-RS-ID;
	bh=xC4wBpwVt5DBUgr5L5OrfGB4RWBaaYkDpsCLYRcAQ3M=;
	b=zKBA9TfVduLmrLYGBbUM0Rgkokq4TtgeDcyEWqRPiYkxTnXm1kefJM1TqJOWAAtm6V4k
	 N7gIHf+cb6ExO0TJA7GjbBN1/UZ0siWutyJcYQ+2Zc8I8DIURK8+ryneloBY+GJEZe5ig
	 /21+wOIyxiQUFjnIagwe2Tl9l8aOrKqVYw+C+VwUc6NgUQVl82J3B/zv60kBUXpfk0bnn
	 7K0e6+dwS+Qc9DGrc3WUrqjH+cnYxJ011xNw+AJJbThJVFlQ7JNZU3YcqsxaUo9NZ6XlB
	 jnIgT3FPNC3z/LHJepkoqvAcVDcUsR0mylZi7B4BjoIc0seyc5id9ImOulZO0MoH0aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=c4Mv+Mtq;
	arc=none smtp.remote-ip=80.241.56.172
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1F8606A31A;
	Sun, 25 Oct 2026 21:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF1F8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=c4Mv+Mtq
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jCV1g3Rm2zMl19;
	Sun, 25 Oct 2026 22:16:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1792962999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xC4wBpwVt5DBUgr5L5OrfGB4RWBaaYkDpsCLYRcAQ3M=;
	b=c4Mv+MtqgDoi/mOwdfjKNIw5tUvRXAwImHOnFHuJJO9uPxSA4Min9bRXghnbVmPrISdoTt
	V3mn5cr6KnpthVb2W4u/dn2Sk2vvbIUBTuPLqqMqtifdEhjv4zuGgHCcIByk5qH4TDScE9
	xNGb0rtbN88VzWxxWSy+oR/96D2fflwCZunnwUOVtb9B+fheheCqL/ov/Yx8VPttIt9H1y
	2jF61ctxoKpjMzhxRpNKZuMn8jluh9XtZjo38gOBj5BynR98MLWhG557mQ9+NghSqaVTtl
	VLXIKjxt9s5Sr26MXJX1nXzMJV6H/TMp3Is3OtSFu7rWSieX/cVPu9nri+XNjA==
Date: Sun, 25 Oct 2026 22:16:36 +0100
From: Anthony Ruhier <aruhier@mailbox.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Baochen Qiang <baochen.qiang@oss.qualcomm.com>, 
	Val Packett <val@packett.cool>, 
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
	Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH] PCI: Disable LTR on Qualcomm WCN7850 [17cb:1107] to
 allow ASPM L1.2
Message-ID: <at5wnfBC0AMyN9ct@tour-anthony.aruhier.fr>
References: <20261023-quick-wcn7850-v1-1-9a139b9b2c8e@mailbox.org>
 <20261023182004.GA2796729@bhelgaas>
 <atvQtV71SbtMK-jZ@tour-anthony.aruhier.fr>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atvQtV71SbtMK-jZ@tour-anthony.aruhier.fr>
X-MBO-RS-META: 1mwu4yke9d14agntr8aehr3b9a3xbpt5
X-MBO-RS-ID: 4097712fceb3e9935af

On Fri, Oct 23, 2026 at 11:49:25PM +0200, Anthony Ruhier wrote:
> By disassembling the firmware with an LLM, I discovered that when wake-on-lan
> is active, it stops this behavior so that the card can go to L1.2. But I
> couldn't find anything else of why it would do this.

Val Packett suggested that I tried to test that in practice to check if that's
true. So I tested enabling WoL and putting the laptop in suspend, but I
couldn't reproduce what the LLM described. So either it's a hallucination or I
couldn't find the right conditions.

So you can ignore this statement.

Thanks,
--
Anthony Ruhier
