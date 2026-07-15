Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA8137DEBB;
	Wed, 15 Jul 2026 14:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784124661; cv=none; b=bDlPCXiEbh5uGMsaDrVlQCq+jV51XFBrt/UXYUpLcAeNs9/Z+TXOwcVRTbSejw+PXLw4+H+rTrtzkaII1lXO/FA7yN5yYg4jXgT7TINhVqsL8VVdHu0l47PNFvuWJ2vCnvm+zlkNzyvjVhQI7YNlLzC/HPu8lbrt9tnJySxW+U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784124661; c=relaxed/simple;
	bh=mjO1eLJTzvr5we4SILqTlLNZXZyPr7noZAruO5jj37s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=flVugeGgDhWEt38BydIImQzVemrbDVFCP3f8ZU6BATPdPUrfxAVEDpfScjgIcFd/zUBpWU58xbEeaaxuZHaM/XYzxFxz6QvKQ3KUU3XQCKu5YsdgdZ+e3Y3T82uuUG9uQsH5/Lct6HM0fV38F5Pcc2ePt8SrrU9jzEm5pqWKtqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=F/V3v9ut; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=N6c52Re9; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="F/V3v9ut";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="N6c52Re9"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4h0dPX65yPzMlH0;
	Wed, 15 Jul 2026 16:10:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1784124656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sWcJy8AVXvzucJnbuxsBlK4QMspmeRMnc/T8cZju6zI=;
	b=F/V3v9ut4Fa/W0qdgPuLDMrZa8vo+KfIr+ksNlDIBXglbUylOvdCqFz0FStzmwuriUxZAG
	Hoe7+6MfFp2vhIIpPVjjCDl3ywqoEh+R6qSN3eu2UVANZz4CIWOjjkB/SYDmqA8gt8at5M
	pl/tOi9uoNnxrrOCeLOAloBJmufOwr+29yU40MP3FIjnZmFRmjTKvAHNBzpTONxHh2xlmL
	XalExZfLK2g9fdLWw5W4lOOZsdOB9PHxM5vMwz15mqjXlMPnHqoR7TAeJcSGRc5xPcqhOG
	PJgyOuu9WmN29nXzzM94drty95cmLylGRWwhz7xDCf3bgr1Dj2RXxyK814P8kQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=N6c52Re9;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <e0e9e2c7-b125-4200-884b-933cc1ea6b2a@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1784124655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sWcJy8AVXvzucJnbuxsBlK4QMspmeRMnc/T8cZju6zI=;
	b=N6c52Re9g/S8W0C50YNI/VnO25lBmCiT3pzg7Arg9HRNCRZ7a/iF2/BWvohnI0kGjpm6nT
	mor+P2e80rkyO67xNEJBMc54VDsQDonKo/0FJM3BW8GjTdBXQgltedDzhRl8DOZuUbGqK+
	rUt1Ex5jW59dICVYrgPXzLgP2EtrOpaS3KevmBYpiI6OGYWW37ojfcq/4y5t6nj/KWzytD
	vtlEx3wskXPWB7TZg6a+Phpsvbo4IBenxpoOQ+Q/B0yoaEng7pFk+j83YGTcOzYo/Qj32S
	ZuttVNnxNUwRYKfH4L1HVF1anPYScQTipghFKUUPpLS+Yyh96Aric0SBiiWrzw==
Date: Wed, 15 Jul 2026 16:10:48 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] PCI: rcar-gen4: Isolate driver to ARM64
To: Manivannan Sadhasivam <mani@kernel.org>,
 Bjorn Helgaas <helgaas@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, linux-pci@vger.kernel.org,
 kernel test robot <lkp@intel.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley
 <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <20260714131957.38067-1-marek.vasut+renesas@mailbox.org>
 <20260714211030.GA1412991@bhelgaas>
 <jipy4hvsmksv6fy352y23sjdnutpkqoi2577qp5vymqqggiscz@cnx2vijnhvh4>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <jipy4hvsmksv6fy352y23sjdnutpkqoi2577qp5vymqqggiscz@cnx2vijnhvh4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 431aabb15f8d3f0014e
X-MBO-RS-META: 3nwked576sj6tfybptqfskq4fgtauqm4
X-Rspamd-Queue-Id: 4h0dPX65yPzMlH0

On 7/15/26 4:03 PM, Manivannan Sadhasivam wrote:
> On Tue, Jul 14, 2026 at 04:10:30PM -0500, Bjorn Helgaas wrote:
>> On Tue, Jul 14, 2026 at 03:19:27PM +0200, Marek Vasut wrote:
>>> The driver includes linux/irqchip/arm-gic-v3.h which pulls in headers
>>> which are available only on ARM and ARM64, on other architectures the
>>> headers are not present and the driver fails to build. This driver is
>>> used only on ARM64 hardware, isolate its build only to ARM64 to avoid
>>> build failures on other architectures.
>>>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Closes: https://lore.kernel.org/oe-kbuild-all/202607100310.iQw5m9Uo-lkp@intel.com/
>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>
>> Mani, I assume you'll squash this into 89bded511a66 ("PCI: rcar-gen4:
>> Configure AXIINTC if iMSI-RX is not used") so it's connected to the
>> addition of the linux/irqchip/arm-gic-v3.h include and there's no
>> bisection hole?
>>
> 
> Yes, squashed now!
Thank you both.
