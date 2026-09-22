Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194E743DEDD;
	Tue, 22 Sep 2026 17:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790099791; cv=none; b=rYR7pfEQu36wmdBi2UxPdBhpcp4/+LUef09Xlq2S7xBryF14dT3bsEL5qe9VOWRs4G3XpbnyoeGFxWiNAbKzXQ/AAZ+23+1jP7USUxhCJPi8oWKeElp0kRFLZoHHGH7eN+ksbOK3LVbsQ8Ng02Dw7Y/7REFtAIGew3o8RPpcVx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790099791; c=relaxed/simple;
	bh=aAZxGG3Ex/win+NDBfLS1UlOD9HHGvLU7fsGs/3OTls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s6MYIABQbxPFhnGl/HU6/frghX6u6EVtHAehs47c/JXqb6AMF66Cxz9U4T/HeJb9RRohZ/9cCsfFSroppudW08q93gibxYTpEupk1TrzQoL6oqaz49CaWxY2UncnupEfrcYPXuhOEdvZw/sBofu2LoYuGWwk63NIp3f+8HJyrSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=YN2idxTR; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="YN2idxTR"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hq77l42Y5zMlC7;
	Tue, 22 Sep 2026 19:56:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790099779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SBEG4FsK95j9fbviMkspvwm0pzpMNNtSJ/vuaMWtuIg=;
	b=YN2idxTR11VFiGxOvfSxyQdczFiJaDPuFfuUlBUBMp3UIbOekODD3rd5o1earJIegJM/Gi
	OIxyvum0bEIATNjOhrSH90tzpMQcQgVXoJcOod9ZrMAGhs72v4Ca18CDet8FRt9h+blwNd
	Z1nTkw96wqeTc9OiJdrVCplnatl1v3uGRMq8fWq5mWe2vUjcDj1z830gz1kB1Q4C3e3R8W
	ihRBlECgAF6ZBqUlwpUphwECTRYOoE5a7swEF0Ihl2liy2juNuWKGzK7IoVi0cUPL6dmFt
	uk+FbrbQgi3izp+xDHQ45iS4NHiroXyJyUSFlYo85z7yoqlU8Pn0gzvx+HTSDQ==
Message-ID: <69187db0-e50f-488b-bb83-08f5029e226c@mailbox.org>
Date: Tue, 22 Sep 2026 19:56:14 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] PCI: rcar-gen4: Add missing PM ops
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Conor Dooley <conor+dt@kernel.org>,
 Koichiro Den <den@valinux.co.jp>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <20260907163554.725127-1-marek.vasut+renesas@mailbox.org>
 <dvcwgdif54jsxqog2v4573ofbheqcvyqcyerisbbuz4rekllqu@aivsgq44yte5>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <dvcwgdif54jsxqog2v4573ofbheqcvyqcyerisbbuz4rekllqu@aivsgq44yte5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 75029b982b8b2165f24
X-MBO-RS-META: tunbssyqix63x9t4nt3e8ee8zid8z67r

On 9/22/26 4:28 PM, Manivannan Sadhasivam wrote:
> On Mon, Sep 07, 2026 at 06:35:22PM +0200, Marek Vasut wrote:
>> The R-Car Gen4 PCIe controller is part of a power domain. On R-Car S4
>> and V4H, this is an always-on power domain which is not shut down in
>> suspend. On R-Car V4M, this is a dedicated A2PCIPHY power domain,
>> which is shut down during suspend, and the controller loses state,
>> which prevents the PCIe from working after resume.
>>
>> Fix this by adding generic suspend/resume noirq ops for the controller,
>> which tear the link down on suspend, and restart it on resume. Use the
>> same PM ops on all of R-Car Gen4 to gracefully suspend and resume the
>> PCIe link on V4H and S4 too.
>>
>> Test case which demonstrates the problem on R-Car V4M:
>> "
>> $ hexdump -vC /sys/bus/pci/devices/0000:00:00.0/config > /tmp/pre
>> $ echo s2idle > /sys/power/mem_sleep
>> $ echo platform > /sys/power/pm_test
>> $ echo mem > /sys/power/state
>> $ hexdump -vC /sys/bus/pci/devices/0000:00:00.0/config > /tmp/post
>> $ diff -Naru /tmp/pre /tmp/post
>> ...
>> -00000000  12 19 32 00 07 05 10 00  00 00 04 06 00 00 01 00
>> +00000000  12 19 32 00 07 05 10 00  00 00 00 ff 00 00 80 00
>>                                            ^^^^^
>>                                      Class 0604->00ff
>> "
>>
>> Fixes: 0d0c551011df ("PCI: rcar-gen4: Add R-Car Gen4 PCIe controller support for host mode")
>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> 
> This patch doesn't apply even after applying [1]. Please rebase on top of
> pci/controller/dwc-rcar-gen4 branch and repost.
Rebased, retested and V4 submitted. Thanks !
