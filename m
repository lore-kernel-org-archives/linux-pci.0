Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F31A3DDDDB;
	Wed, 11 Mar 2026 11:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773229569; cv=none; b=FPG2t8gaiWf1e3FRhK8qs/sxqwfDGyV4YDF7If3ShoulC0waV3v7vs6JX1mq8Zs9aG6q8j8yKLqU7wAyF92qazedOYL7e6Xsv/89SBGrNRj1/19QzYNbZB8Ewn2e7iP3Oz8smP/qWSG1jpmhXYcQMBady1jgZ7laXrATKSZeqCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773229569; c=relaxed/simple;
	bh=mePPF9zcPSvtBJqRo2t1V0QkuJgJRZztiTUUZcbcg0Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=XEvAKwX/pm/27/pG6SFRl0kQNCJ7LT4xiNKSTLWAJxhubxnKmS1o07OwwFuuRhBz7iubelnr3nzbmOzqoxKQp3mkBX++jAjfsX+8YSgsokjRRKt5gE4FmVOuUmvfHOiWVCOhwOI71ladStdTpAFIA4Yuiy16DOcGEcO9Z+Aoh9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LL43S37g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LL43S37g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79082C4CEF7;
	Wed, 11 Mar 2026 11:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773229568;
	bh=mePPF9zcPSvtBJqRo2t1V0QkuJgJRZztiTUUZcbcg0Y=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=LL43S37gfzT/Tm97KcgLsUXSfiOoxXzNEvUrv5x20U2bjXaNgs2ZEmAgEqPArpUoO
	 jMRBsFO1rtnAFbU7NnV1UYL2ZLu78aO4zL8Y7m8Bk2MEOzq5U5kiR9/6SUzZYukt7x
	 YCTfvAKZMs3yfoGP49cGvPDmIt42flrR6PfRuh5zAIQmyzPxgztNsbO/gK+Je4YLce
	 ciCMdoBBXH0iGc+dE87FOkoBu6Uce/jRT/Ya7GEyH4/7KkWuHPyqX8nSztSBQvw3vL
	 L8FegqH/dGZqRNCpbuvVZrTfiR676Um5mvDDVFYh66XpUXS9leC3rE1c8nNUescbmb
	 xFoVtT4VD+7vg==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Mar 2026 12:46:03 +0100
Message-Id: <DGZXF3LPSRK6.2QYN63QTKUQAX@kernel.org>
Subject: Re: [PATCH v3] PCI: dw-rockchip: Enable async probe by default
Cc: "Robin Murphy" <robin.murphy@arm.com>, "Manivannan Sadhasivam"
 <manivannan.sadhasivam@oss.qualcomm.com>, "Lorenzo Pieralisi"
 <lpieralisi@kernel.org>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Rob Herring" <robh@kernel.org>, "Bjorn Helgaas"
 <bhelgaas@google.com>, "Heiko Stuebner" <heiko@sntech.de>, "Niklas Cassel"
 <cassel@kernel.org>, "Shawn Lin" <shawn.lin@rock-chips.com>, "Hans Zhang"
 <18255117159@163.com>, "Nicolas Frattaroli"
 <nicolas.frattaroli@collabora.com>, "Wilfred Mallawa"
 <wilfred.mallawa@wdc.com>, <linux-pci@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 "Anand Moon" <linux.amoon@gmail.com>, "Grimmauld" <grimmauld@grimmauld.de>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, <driver-core@lists.linux.dev>, "Lukas Wunner"
 <lukas@wunner.de>
To: "Manivannan Sadhasivam" <mani@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260226101032.1042-1-linux.amoon@gmail.com>
 <177260693908.10259.13055467642416391434.b4-ty@kernel.org>
 <87bc37ee-234c-4568-b72e-955c130a6838@arm.com>
 <f7tfshf7riljjibuqge4ubfjmludubpyh3ppdf6lasurzdzbtj@sw4xxagfhnn3>
 <5d88fb5b-e771-4ea6-8d2c-c5cfd21e5860@arm.com>
 <qwanhqrpztzkudik5fmberhabnzaly7v53677dohqzj5nq4wi2@6ndpiubyxcbi>
In-Reply-To: <qwanhqrpztzkudik5fmberhabnzaly7v53677dohqzj5nq4wi2@6ndpiubyxcbi>

On Wed Mar 11, 2026 at 6:24 AM CET, Manivannan Sadhasivam wrote:
> I have a contrary view here. If just a single driver or lib doesn't handl=
e async
> probe, it cannot just force other drivers to not take the advantage of as=
ync
> probe. As I said above, enabling async probe easily saves a few hunderd m=
s or
> even more if there are more than one Root Port or Root Complex in an SoC.

Then the driver or lib has to be fixed / improved first or the driver core =
has
to be enabled to deal with a case where PROBE_FORCE_SYNCHRONOUS is requeste=
d
from an async path, etc.

In any case, applying the patch and breaking things (knowingly?) doesn't se=
em
like the correct approach.

> I strongly agree with you here that the underlying issue should be fixed.=
 But
> the real impact to end users is not this splat, but not having the boot t=
ime
> optimization that this patch brings in. As an end user, one would want th=
eir
> systems to boot quickly and they wouldn't bother much about a harmless wa=
rning
> splat appearing in the dmesg log.

You mean quickly booting into a "harmless" potential deadlock condition the
warning splat tries to make people aware of? :)

(Or am I missing a subtle detail and we can never actually end up in a dead=
lock
for some reason?)
