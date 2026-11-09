Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794257953;
	b=fYRJc+vKqF6JJdwlwQlEmWag0hKeI2TZr6Lz7l3KxUzYytgRNXBFMZeou5p3qObEJddr
	 RHRP+ELXggxk1MborNjiAMVETC2CQSeuVSUBb2RLZZZTRULVxBCHTXx0PQvIDXidneb27
	 JbIAe2do7U15RPRpQR1kXtdNt/SgiWURP/zopxy63nJQyuUIX3yWxmybEWRA8A4Lzayrs
	 lV2+Cvv7i3LlgMzGu3ZOMCKxXbe2+4+4UWsiyJjq04paqX7Tei3gUNz0rnfmkJCLaOxuk
	 pHOVgnEGiSTqshlmg5im0XBNyH4KVedKUu9uD7AdzM3EBmmUm6gi7REN9HvJCFmIkkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794257953;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=OKIk6rnFZ6VmNTZhn1YkBpy13BJSr4y4E6v2+iMZxUI=;
	b=bA0Xl2r0NM2t3E10Z+njZ8LxgPkiExvhxP4ZM/G1CYabkBMU2/SZKU3zdMb5sWW+TVfR
	 lUhkP5OFK7JVBJKOC2R5/zqoPKeE6E5J5gGU3ydiEu1uhwFgDrjkvYkerQoIybli6CwAL
	 WJtwcCKB/q4x22TJW884RRlu3gYaDl9CTZn0Pdt45ursMxtj5hZZ+gFSeRw5+ITJnDFfx
	 9urWUSXYPbnLeQEf3PCoM5+YIXY3zYJhCQbY1Gz2fM9b4PBQSx/gQVh4aZ4BWlmSEuoEX
	 hn83FQsDIjWTqLKoDsMpw+5oIVjzcexeNaOM5ctPwcTcN25/HEQFirhfj0SG0ndjWDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EeDIV6bs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEF1606A321;
	Mon,  9 Nov 2026 20:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EeDIV6bs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 878741F0089F;
	Mon,  9 Nov 2026 20:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794257952;
	bh=OKIk6rnFZ6VmNTZhn1YkBpy13BJSr4y4E6v2+iMZxUI=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=EeDIV6bseeGWOEYh7Znh4Kj8Zq8ivM4dw9jyixYC9Xos0t6GtWEMpY2uV6MzziW9s
	 bIk/BUTpKRhLcRwesJmKQ8a9WrqxuoWL4kig82NAIqXZ/hPbAu5iQPzwlAcF5Fn/i0
	 GjrMWYmyIy4Hddv0PSM0HVrqHfGV4MDg86b7KrT+we5f3LX+rfot199K5+eLwNdXKj
	 ljDlYfOBgFYxiFM7GwouzusMmJz6eu4QZxN316/1fistBQhgNZa1YRWYobJMynxU02
	 2JFIqLc7tSWBLm/b5lhmPEdEz7Vwtai3Pp2eysShu9dXkFo7+GExsCtyiVFU4PC8ch
	 pq53+t1iZ99qw==
Date: Mon, 9 Nov 2026 14:59:11 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Igor Velkov <iav@iav.lv>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
	linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: rockchip-host: Enable async probe by default
Message-ID: <20261109205911.GA292554@bhelgaas>
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
In-Reply-To: <20261109204122.async-probe-reply@iav.lv>

On Mon, Nov 09, 2026 at 10:47:39PM +0200, Igor Velkov wrote:
> On Mon, Nov 09, 2026 at 02:22:02PM -0600, Bjorn Helgaas wrote:
> > I don't know what the SD card has to do with PCIe.  Seems like there's
> > some SD issue, and making PCIe async happens to avoid it?  Sounds
> > fragile to me.
> >
> > Other changes like c0e1eb441b1d justify it by allowing other drivers
> > to load in parallel to reduce boot time, which is a good reason.  But
> > apparently here it makes a functional difference as well, which feels
> > sketchy.  E.g., what other drivers need to use async probe to avoid
> > similar issues?
> 
> You're right that the real problem is ordering: nothing makes dw_mmc wait
> for the RK3399 io-domain driver, which sets the 1.8 V level of the SD
> pins. [1] tried to add that dependency and was not merged. Async probe
> only stops this driver from holding the deferred-probe worker for ~0.7 s;
> any other slow probe in that window breaks UHS the same way.
> 
> Is there a way to express this dependency that you would accept?
> 
> [1] https://lore.kernel.org/all/20230904115816.1237684-1-s.hauer@pengutronix.de/

Mani's already applied it, so I think it's fine.  I'm just trying to
understand the commit message and figure out what the merge commit log
and the eventual pull request should say.  It sounds like "this makes
SD cards work better" is somehow part of it, but it just feels kind of
hand-wavey.
