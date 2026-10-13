Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0753C517BC7;
	Tue, 13 Oct 2026 13:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791898552; cv=none; b=ojYDKkNzJi1wuVHFh6wUiET86dR9jgrqJx83n/ycDflEsvjNxvnEFLyj/NZiPE39QH1lXu804elQg0oUGEfkkjO8WuFbF4NtEnvJthQMbUk8F5vvnVJ360hKwLyubBuK+qE5QpaSsVefVH4ybH+VXthpnTNzerF0I8DHCi3VLaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791898552; c=relaxed/simple;
	bh=cNKHtVoCd+IT/8DReUMUq/MN+gNiyYtWwc8VBTF8ENk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXDJA42qW7JcS5ZFR5xrdKFSdlI6pivvBCKWAWf73coj/TJuLSCdSp8eG9XQKbpkXlCEpv2TwgSWLVs1xoDMNkLpMmHKHQeZEh8B5DFEx0TucOmO/dmvSnTtNlQ9sANP+SWoRJXoTfU+P9sC5uGXcal2TulmmSODySIaMT3kKhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGVnqy2y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGVnqy2y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC8EE1F00893;
	Tue, 13 Oct 2026 13:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791898551;
	bh=cNKHtVoCd+IT/8DReUMUq/MN+gNiyYtWwc8VBTF8ENk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dGVnqy2yXOTVA6pRgQ8AIA5CfqEHXIrzsvnXGDHaSnu0uIRJcg+JBocJw/B5cA0XJ
	 s5adVL3v/IlVyNrkqz3WOt6u63Z0R1zgkcHXl8BE5BcBt1W2+0JXzD30aKrMhZTo4V
	 emthvnEgNuEMvNRTgo9m6zhGupQ7mJn4BpOBuAS8gbpV1g7nI15zHFMZbL9ZYt+maq
	 NZHsh9/glJFdyddBUPpTA8kKPW5ey3ENnmP35jmh7ugD6oQH7CQ6EBz/O50O224pbr
	 4REuRAwcC5fUFUvYT5JORS+vFUAEQkAbOLpkRjPNLJ5KpWEPRfUFoeB5XwnZ9s9FV/
	 YN2z6EyGMNwjA==
Date: Tue, 13 Oct 2026 15:35:44 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Imre Kaloz <kaloz@kernel.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, mfd@lists.linux.dev,
	linux-serial@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-rtc@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	linux-ide@vger.kernel.org, Pavel Machek <pavel@kernel.org>,
	linux-leds@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 00/53] MIPS: SGI-IP27: add support for the IP35
 (Bedrock hub) machines
Message-ID: <as4zsLZvV411ooEv@ryzen>
References: <cover.1791890466.git.kaloz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1791890466.git.kaloz@kernel.org>

Hello Imre,

This series is rather large.

I would recommend you to submit a minimal patch series
to get the basic support for your new board, such that
it can boot with a ramdisk and serial console.

Then in the next cycle, send separate series for ata,
net, leds, mfc, rtc, etc.


Kind regards,
Niklas
