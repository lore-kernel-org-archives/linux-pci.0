Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BDC324716;
	Wed, 11 Mar 2026 21:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773263365; cv=none; b=PFa6GxemjTfx9ymK4h6v/rzBirTmAWh+BgfgFdciag1vQqw3Z/5kBB7poeoKcVuAJYfdQcQfmWU8IhV1n9EJ9ZtfMHP4goITFX5hJ1/CAvAI78crI0niihD5OTQuOc4SA3Idj7T8ArEhWBmdyC0bQ3XLFt6FauEMh8E4G1nI888=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773263365; c=relaxed/simple;
	bh=0rXaMvGNi4+OvPnGl2fgoLlfPW/6GtuSV3FJJcwDS9M=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Qw0DeQWZToxXzygkcqpCusukGVQaBPZUEhBJZ8wHm/hbjQ0K6bBp3m3g3OGsDpGGLLf0mPCZxU9Ur/gC01DY+JJXnnYxqqkwt7IGXqiyxr5WzCqpocEZJIOIGSfI39KvwQoj9iBwxY99cWgCwiMhcyG/ADfHL5WY704HSV0sCzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nTY9OMOC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nTY9OMOC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED2FC4CEF7;
	Wed, 11 Mar 2026 21:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773263365;
	bh=0rXaMvGNi4+OvPnGl2fgoLlfPW/6GtuSV3FJJcwDS9M=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=nTY9OMOC9F7kBpERi6z30FTuaZPxVl5Fv76LmjUo5otKD3FEeRahGXzKjzBHLciW/
	 vsFHQE05z41uqlhKhSf82H6e/E4Nzu9yGSGunIZ9o4u6pDNHpQYJyKgpZB6+0m5s1D
	 cAewcAljEd7Hj7kuJulzboI2aN1KxsQbjjxPrm3U6Pu/bOyjMJ6EBuAu7Zg/qeb4B0
	 f6ToSmUPcZdepsHbptQjimEa08e1m8i4KaHUqNpNAR6l4j2zh0wNXnIpDSkMMMCK27
	 3T5aLWdjgAYUE16y8cGqZfrCI7WYozbJwRtjgPtBEKCMJrNi+E6cOP74wmmn8fZt4t
	 s51IXrEVJ8MCw==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Mar 2026 22:09:19 +0100
Message-Id: <DH09EDBW3X6T.2996UB1CFCAW2@kernel.org>
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
 <DGZXF3LPSRK6.2QYN63QTKUQAX@kernel.org>
 <cp5uktfqdf6zs53qsye57ior2ikmssgevxxdtevkzpisaif22h@7mrxspkuibow>
In-Reply-To: <cp5uktfqdf6zs53qsye57ior2ikmssgevxxdtevkzpisaif22h@7mrxspkuibow>

On Wed Mar 11, 2026 at 1:28 PM CET, Manivannan Sadhasivam wrote:
> On Wed, Mar 11, 2026 at 12:46:03PM +0100, Danilo Krummrich wrote:
>> On Wed Mar 11, 2026 at 6:24 AM CET, Manivannan Sadhasivam wrote:
>> > I have a contrary view here. If just a single driver or lib doesn't ha=
ndle async
>> > probe, it cannot just force other drivers to not take the advantage of=
 async
>> > probe. As I said above, enabling async probe easily saves a few hunder=
d ms or
>> > even more if there are more than one Root Port or Root Complex in an S=
oC.
>>=20
>> Then the driver or lib has to be fixed / improved first or the driver co=
re has
>> to be enabled to deal with a case where PROBE_FORCE_SYNCHRONOUS is reque=
sted
>> from an async path, etc.
>>=20
>> In any case, applying the patch and breaking things (knowingly?) doesn't=
 seem
>> like the correct approach.
>>=20
>> > I strongly agree with you here that the underlying issue should be fix=
ed. But
>> > the real impact to end users is not this splat, but not having the boo=
t time
>> > optimization that this patch brings in. As an end user, one would want=
 their
>> > systems to boot quickly and they wouldn't bother much about a harmless=
 warning
>> > splat appearing in the dmesg log.
>>=20
>> You mean quickly booting into a "harmless" potential deadlock condition =
the
>> warning splat tries to make people aware of? :)
>>=20
>
> Hmm, I overlooked the built-as-module part where the deadlock could be po=
ssible
> as indicated by the comment about the WARN_ON_ONCE().
>
> But what is the path forward here? Do you want the phylib to fix the
> request_module() call or fix the driver core instead?

Here are a few thoughts.

In general, I think the best would be to get rid of the (affected)
PROBE_FORCE_SYNCHRONOUS cases.

Now, I guess this can be pretty hard for a PCI controller driver, as you ca=
n't
really predict what ends up being probed from you async context, i.e. it co=
uld
even be some other bus controller and things could even propagate further.

Not sure how big of a deal it is in practice though, there are not a lot of
PROBE_FORCE_SYNCHRONOUS drivers (left), but note that specifying neither
PROBE_FORCE_SYNCHRONOUS nor PROBE_PREFER_ASYNCHRONOUS currently results in
synchronous by default.

(Also, quite some other PCI controller drivers do set PROBE_PREFER_ASYNCHRO=
NOUS
and apparently got lucky with it.)

From a driver-core perspective I think we're rather limited on what we can =
do;
we are already in async context at this point and can't magically go back t=
o
initcall context.

So, the only thing I can think of is to kick off work on a workqueue, which=
 in
the end would be the same as the deferred probe handling.

Another alternative would be to let the subsystem handle such cases, which =
in
this case would probably mean to handle the current_is_async() case in
pci_host_probe() or pci_bus_add_devices().

On the other hand, this would probably end up to be a subsystem specific
implementation of "kick of work on a workqueue".

> I can drop this patch in the meantime. But holding this prolong wouldn't =
help.
