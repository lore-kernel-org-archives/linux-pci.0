Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B2F2BE7D1;
	Wed, 25 Mar 2026 15:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774451590; cv=none; b=jwZD1xuNkWDqISSRCMlY0z/UzsacIFGgJ4O2YfwaMPyjYzJbsv9iCY/a8NPfrfb2GqlgtnOx9tFNs4yvvhLxnMRIF0BW41NX3vsT/jvpjchLQYVeRpOQKxN/kTA2RhouefqS2KGn98H6yD0JWsbsnhRj5rVBPCVavyONIhhtSmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774451590; c=relaxed/simple;
	bh=K7TzBX/q1XwvUhD9Psm0P5f4ncQ+WOH4GmJMJmXDjUQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=KZLDOB5j9IdEqM2rnAh8MH+t0UKdRS5m0Rz4rAwQ9lc/EHDQu8iTOrKFJ5vBfhnhCYbBcMZcNn4Kn3RSlFrr7hTcKYMQMqzuwrGrV4zUhyw7BoDf2TFIKLZC2pI6hbeVHVZ+xSO7u9TRo1cc0ip0ZlDkkY5nbZvcBKyjNpI/Wp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OqOJTe2N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OqOJTe2N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F0B7C4CEF7;
	Wed, 25 Mar 2026 15:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774451589;
	bh=K7TzBX/q1XwvUhD9Psm0P5f4ncQ+WOH4GmJMJmXDjUQ=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=OqOJTe2NPRk7csjnxf5jwiW92DOlbSQ2D6ijigRGEjmcK3nophEMcIOJIaVYe/jV6
	 RRq7yBsg+FzRe+Fzsv8l1NB5uQ7msYF4iEdl5ewEsnXKxbQkh41RTlMycrB053j4rD
	 KT53qmxCphZ3cApZM3yv1G6molPuah80zE0d+89zzPuxwKUhBYJthImx0+QtFM/Zhz
	 0JPYh01YKgOZtZY1de8DkD/O1X2p98fwuj2HjsU0sTiVchb6NWbuPcdhst5oYgNLen
	 y1hPdC/Xm8m5ucOwC71g8RvaZnI+Ax5dlCrUlAeStI43sKjPE0KnYtNUVMpUYvY4SY
	 Cw9NzJyV3y5IQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Mar 2026 16:13:03 +0100
Message-Id: <DHBYL7Y262J2.263EOC2JNN4RK@kernel.org>
Cc: "Robin Murphy" <robin.murphy@arm.com>, "Manivannan Sadhasivam"
 <mani@kernel.org>, "Manivannan Sadhasivam"
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
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3] PCI: dw-rockchip: Enable async probe by default
References: <20260226101032.1042-1-linux.amoon@gmail.com>
 <177260693908.10259.13055467642416391434.b4-ty@kernel.org>
 <87bc37ee-234c-4568-b72e-955c130a6838@arm.com>
 <f7tfshf7riljjibuqge4ubfjmludubpyh3ppdf6lasurzdzbtj@sw4xxagfhnn3>
 <5d88fb5b-e771-4ea6-8d2c-c5cfd21e5860@arm.com>
 <qwanhqrpztzkudik5fmberhabnzaly7v53677dohqzj5nq4wi2@6ndpiubyxcbi>
 <DGZXF3LPSRK6.2QYN63QTKUQAX@kernel.org>
 <cp5uktfqdf6zs53qsye57ior2ikmssgevxxdtevkzpisaif22h@7mrxspkuibow>
 <DH09EDBW3X6T.2996UB1CFCAW2@kernel.org>
 <55c28218-1638-4b90-a9cd-a177fb5abcb6@arm.com>
 <acNgUoWWMCi1oLU4@google.com>
In-Reply-To: <acNgUoWWMCi1oLU4@google.com>

On Wed Mar 25, 2026 at 5:13 AM CET, Dmitry Torokhov wrote:
> That means that you are kicking the majority devices (for now) into
> deferral path. I do not think this is optimal.

That's not necessary, we'd only need to kick those into the deferral path t=
hat
have PROBE_FORCE_SYNCHRONOUS, no?
