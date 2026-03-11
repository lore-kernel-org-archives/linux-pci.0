Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE903DD510;
	Wed, 11 Mar 2026 12:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773232125; cv=none; b=VLNHk2IyxhNEnzOLVz6cElNlbnC20WlxQeLoK6TFURX46Niwehxazgz7vJOWjI67bl8UDfeZHdxmTFGUIs2C5vJs3zf1Crk8hITNKhAVQtbrk1PvTPBPp4yf13VSl5O3ZkL7FudnYqqMb4n+nq40u4c4wxgk5OKbj5pyhkmBJso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773232125; c=relaxed/simple;
	bh=WuY0INtBXp4bdO1U7Nbe5xqaanpsrysVxQk4S6c9FJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPTliCv81nzVJu3+x6Iu0nTZvRk2Qg+YcrnPAzslnqSwsLqgXUGJWmwjcaxc+Dr8opyOt6DTY9pdJozF+bQMD5e89UprYmVZPmKlp7uutRu7CS4lRGCQS7V/XGbOpKjSEHl6LWCDaYaEP8FQcK+pExVCrMHquSR+onyeEaCH+JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzdROzh4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzdROzh4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E196C4CEF7;
	Wed, 11 Mar 2026 12:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773232125;
	bh=WuY0INtBXp4bdO1U7Nbe5xqaanpsrysVxQk4S6c9FJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kzdROzh4Rp4Awq3KG6vcTN0jZmJEl9lTvk2wAzo/euSWUrAGp/0mG1zTn5WTwyPBS
	 qIy0pOO4VNPy4Mob6sato7lSAcfmKli4OidYuI0tO78gBVvkeamOJ3ZbBElZciUoRm
	 4h5ygxchTqQeBrn59Aw7z/dE6vb9l5sAc68YhkFpfL6Q/5/TULltm4Qo5SXCIoC8+L
	 /cIgawapsiF0AE5tXzGdBfwqhKixaleuz1bq0kUfmOwEVQLzbD/HEIfhRUu0J4ya1y
	 ffzAe3+ukODyjdlYDcoawMqEWuhS5NryHvzXkGgkUeAXsQgvKPzYm5voX5udL+vCSZ
	 8ybyTcxHtD6bQ==
Date: Wed, 11 Mar 2026 17:58:26 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	Niklas Cassel <cassel@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, 
	Hans Zhang <18255117159@163.com>, Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
	Wilfred Mallawa <wilfred.mallawa@wdc.com>, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Anand Moon <linux.amoon@gmail.com>, 
	Grimmauld <grimmauld@grimmauld.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, driver-core@lists.linux.dev, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v3] PCI: dw-rockchip: Enable async probe by default
Message-ID: <cp5uktfqdf6zs53qsye57ior2ikmssgevxxdtevkzpisaif22h@7mrxspkuibow>
References: <20260226101032.1042-1-linux.amoon@gmail.com>
 <177260693908.10259.13055467642416391434.b4-ty@kernel.org>
 <87bc37ee-234c-4568-b72e-955c130a6838@arm.com>
 <f7tfshf7riljjibuqge4ubfjmludubpyh3ppdf6lasurzdzbtj@sw4xxagfhnn3>
 <5d88fb5b-e771-4ea6-8d2c-c5cfd21e5860@arm.com>
 <qwanhqrpztzkudik5fmberhabnzaly7v53677dohqzj5nq4wi2@6ndpiubyxcbi>
 <DGZXF3LPSRK6.2QYN63QTKUQAX@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DGZXF3LPSRK6.2QYN63QTKUQAX@kernel.org>

On Wed, Mar 11, 2026 at 12:46:03PM +0100, Danilo Krummrich wrote:
> On Wed Mar 11, 2026 at 6:24 AM CET, Manivannan Sadhasivam wrote:
> > I have a contrary view here. If just a single driver or lib doesn't handle async
> > probe, it cannot just force other drivers to not take the advantage of async
> > probe. As I said above, enabling async probe easily saves a few hunderd ms or
> > even more if there are more than one Root Port or Root Complex in an SoC.
> 
> Then the driver or lib has to be fixed / improved first or the driver core has
> to be enabled to deal with a case where PROBE_FORCE_SYNCHRONOUS is requested
> from an async path, etc.
> 
> In any case, applying the patch and breaking things (knowingly?) doesn't seem
> like the correct approach.
> 
> > I strongly agree with you here that the underlying issue should be fixed. But
> > the real impact to end users is not this splat, but not having the boot time
> > optimization that this patch brings in. As an end user, one would want their
> > systems to boot quickly and they wouldn't bother much about a harmless warning
> > splat appearing in the dmesg log.
> 
> You mean quickly booting into a "harmless" potential deadlock condition the
> warning splat tries to make people aware of? :)
> 

Hmm, I overlooked the built-as-module part where the deadlock could be possible
as indicated by the comment about the WARN_ON_ONCE().

But what is the path forward here? Do you want the phylib to fix the
request_module() call or fix the driver core instead?

I can drop this patch in the meantime. But holding this prolong wouldn't help.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
