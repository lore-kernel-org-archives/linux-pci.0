Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E150C51814B;
	Tue, 13 Oct 2026 14:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791901614; cv=none; b=t/BHeGtZ3aDOn2t87hyJ1D8FjIuQMEfuesZT3qK89MRC8+vpC8dSmocowgmMuvn13zZEe1wHNrmbtCKpDzqhA6Qudyo8HhRtQo9zTVDf+77isb5XScKiSX06wTiPI2g+f9B4TtUEpS6rxw1OFXt65EQz7OP4xm4JEFV77b5Z8hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791901614; c=relaxed/simple;
	bh=XfZVuH37TjJbVLTM/jEvSNl35LQfRki5rmhJIud0Ta0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=W22b3GDrs2wJr2fAAyV3PK9zi0blscSclNyffSYbSfJicAuhCWkTWp52+uEc6mjMJ05de6VpVybUezhfFuHxex3Tw/hzP6OhSSLFYST9J60P62Doi30CStIMEr4MXO4An9rJ5l+AlCQhxXuSl9Hp/CCveWNIV0svv5iJYSDEeXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M84dz03/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M84dz03/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67CAC1F000FF;
	Tue, 13 Oct 2026 14:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791901613;
	bh=Vu9GFTSwpA+ThnhYFOK02kJtnNFAzU/CFrFuq53MJ60=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=M84dz03/ue983O1uOEriK2mgDcd8I0/vK6Wc4QCEqLcvOhVeUdQBHbaY2nuLf+iK/
	 XxomRz5py81Ziy9sUEwpXdILr5KvWnvev6t8n7wyw6HkYDK5aoD9KRd8XOOKyvX3rj
	 GQFYmV+CPCyD+120q7nulE5M9oTcSmjPo88uleWGa83Add7aiqXDFuoeLEX3yUaA9S
	 V+djX8SDohHXmxu8z+AnJ5ZG5HwMWSwG5XpFun/GHc15TVd3t9wsuZzZ8nS7MEADwm
	 HOxyxVw/pZ2GfT7d272Ud9GtVDy+bRNWC3M6hvF9U06Dh/vTYKKi+J8Vj14Yq62tZS
	 EtCRK0fPHxjPg==
Date: Tue, 13 Oct 2026 16:25:46 +0200 (CEST)
From: Imre Kaloz <kaloz@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
    Lee Jones <lee@kernel.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, mfd@lists.linux.dev, 
    linux-serial@vger.kernel.org, 
    Alexandre Belloni <alexandre.belloni@bootlin.com>, 
    linux-rtc@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
    Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org, 
    Pavel Machek <pavel@kernel.org>, linux-leds@vger.kernel.org, 
    Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 00/53] MIPS: SGI-IP27: add support for the IP35 (Bedrock
 hub) machines
In-Reply-To: <as4zsLZvV411ooEv@ryzen>
Message-ID: <24d821f4-63ff-aa35-a36f-a72046fe59a7@kernel.org>
References: <cover.1791890466.git.kaloz@kernel.org> <as4zsLZvV411ooEv@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1641235930-1791901553=:27186"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1641235930-1791901553=:27186
Content-Type: text/plain; charset=ISO-8859-7; format=flowed
Content-Transfer-Encoding: 8BIT

Hello Niklas,

On Tue, 13 Oct 2026, Niklas Cassel wrote:

> Hello Imre,
>
> This series is rather large.
>
> I would recommend you to submit a minimal patch series
> to get the basic support for your new board, such that
> it can boot with a ramdisk and serial console.
>
> Then in the next cycle, send separate series for ata,
> net, leds, mfc, rtc, etc.

Hi Niklas,

Thanks for having a look. I checked what the minimum is: 31 of the 53 
patches (1, 6-24, 26-29, 31-36 and 39) boot a Tezro to a ramdisk with a 
serial console. Two mfd/ioc3 patches have to be part of that, as they 
provide the console UARTs (31 for IOC4 on the Tezro, 36 for the IOC3 on 
the Fuel). The rest separates cleanly into follow-ups: the remaining 
Bridge fixes (2-5), ioc3-eth (25, 38), rtc (30), the IO8 serial IRQs (37), 
machine identification and the Odyssey widget (40-44), ata (45-47, 49), 
the defconfig refresh (48) and the LEDs (50-53).

I¢ll wait for Thomas to say whether he prefers it split that way for v3.


Thanks,
Imre
--8323329-1641235930-1791901553=:27186--
