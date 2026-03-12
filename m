Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8951F0E25;
	Thu, 12 Mar 2026 11:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773316454; cv=none; b=WlLO8npUJ8aLQjtsvqB8bx72AFkyokLhCaWO6vyMNDlULhWg4oosGOoL/YM8tcvUkObyC93zY2COwnv8vmWcw1IB4yfii1xvM61aZ8ucWykBod1a59rS8x1oH8zKqUPa7JbaSwL8PHuPqOXr/O0TCQQ1HhKTVmiqvn0UYILGy0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773316454; c=relaxed/simple;
	bh=GFgJm7FJgsQRl61HV8czMQRDpf/YqHn7PSxSflvCbMI=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=lz+W0v/Tpo/rTByKWrmGJXF3AJHtC9AwJNtY4kGgVr7CJoLBbDi1BrcaN/TLhDxl4iIxltTFxIifZhkMZIgBDHWK5TBUSvvfKAwMlDKvQrcwEB0uI6JUe9Qq+uMrZZ9UTYpcPDx92jDXNMdYZfMUE94CHH8M6iQVuBWhIh7Zm7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPH8TnCU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPH8TnCU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38699C4CEF7;
	Thu, 12 Mar 2026 11:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773316454;
	bh=GFgJm7FJgsQRl61HV8czMQRDpf/YqHn7PSxSflvCbMI=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=nPH8TnCUL2kGIzTtgZZ4CYLQNNDXeLRqR+eRjCqbkYzyaVYo+BzsmW65nokTqHm7t
	 /WgvdkNolDn69vhIA/RhnJwgZ52d+xXM0Z6XNsXvMuI0GvWaIfmgaPWjU6nnYYf+IV
	 KBeUJjEE2UQkXXf8at7zV+SRKgL98rMZqhtLe0nVZo5aTD5KqJLk7m/jFtbrXNl7TM
	 olGrnunrzqweWBBNvTrusH+J2YjY4eo4eBR8PehH9HSPAvhUr59kusRMYL9aPZ3ltV
	 kPULJxd3k+PIe32DfSTDTe1tjuYpMlJUpQrLuTPhr74CEzfWEFJ9ie7+N8di+nOVJr
	 xX3CZ2bCD/tSQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Mar 2026 12:54:07 +0100
Message-Id: <DH0S7TSFKDJV.2YPSBH9F142LL@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3] PCI: dw-rockchip: Enable async probe by default
Cc: "Shawn Lin" <shawn.lin@rock-chips.com>, "Manivannan Sadhasivam"
 <mani@kernel.org>, "Robin Murphy" <robin.murphy@arm.com>, "Manivannan
 Sadhasivam" <manivannan.sadhasivam@oss.qualcomm.com>, "Lorenzo Pieralisi"
 <lpieralisi@kernel.org>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Rob Herring" <robh@kernel.org>, "Bjorn Helgaas"
 <bhelgaas@google.com>, "Heiko Stuebner" <heiko@sntech.de>, "Niklas Cassel"
 <cassel@kernel.org>, "Hans Zhang" <18255117159@163.com>, "Nicolas
 Frattaroli" <nicolas.frattaroli@collabora.com>, "Wilfred Mallawa"
 <wilfred.mallawa@wdc.com>, <linux-pci@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 "Grimmauld" <grimmauld@grimmauld.de>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 <driver-core@lists.linux.dev>, "Lukas Wunner" <lukas@wunner.de>
To: "Anand Moon" <linux.amoon@gmail.com>
References: <20260226101032.1042-1-linux.amoon@gmail.com>
 <177260693908.10259.13055467642416391434.b4-ty@kernel.org>
 <87bc37ee-234c-4568-b72e-955c130a6838@arm.com>
 <f7tfshf7riljjibuqge4ubfjmludubpyh3ppdf6lasurzdzbtj@sw4xxagfhnn3>
 <5d88fb5b-e771-4ea6-8d2c-c5cfd21e5860@arm.com>
 <qwanhqrpztzkudik5fmberhabnzaly7v53677dohqzj5nq4wi2@6ndpiubyxcbi>
 <DGZXF3LPSRK6.2QYN63QTKUQAX@kernel.org>
 <cp5uktfqdf6zs53qsye57ior2ikmssgevxxdtevkzpisaif22h@7mrxspkuibow>
 <DH09EDBW3X6T.2996UB1CFCAW2@kernel.org>
 <7b5592e7-8a9d-2cf0-bb3e-e306a6337165@rock-chips.com>
 <CANAwSgTaZqsHYXD_ACkJGGLgk4knc7N72f4qrJaaenE-cXM8BA@mail.gmail.com>
In-Reply-To: <CANAwSgTaZqsHYXD_ACkJGGLgk4knc7N72f4qrJaaenE-cXM8BA@mail.gmail.com>

On Thu Mar 12, 2026 at 12:40 PM CET, Anand Moon wrote:
> I've reproduced the issue on my end. Following Danilo's suggestion,
> I used PROBE_FORCE_SYNCHRONOUS to resolve the warning.

I did not propose to add PROBE_FORCE_SYNCHRONOUS, I just noted that we shou=
ld
not force all subsequent drivers into async probe() by adding
PROBE_PREFER_ASYNCHRONOUS before the issue is resolved.
