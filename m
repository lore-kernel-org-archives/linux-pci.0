Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E28DCA4E;
	Thu, 24 Sep 2026 00:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790210409; cv=none; b=Dcr9EuDj8C9DChhdvKqwfNr0VRD4skm1BN0Cc2PMICXv4qSVsYxWUwmg8ksgzxj+MlhXOfIYA3Q+4x/L4jYmvzsqO9YSmsSo8bNIeO/Y5xZFrU6xT/SaqaVowk9U7j17oJZ0pe3O3sPxTEapcv5SmuHeI+OAaInXYRZF1G/XLkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790210409; c=relaxed/simple;
	bh=64uXb4X38XrSq/BVvQdzMJq2eRbmsD2MiKhrL+mD7IU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dfyHEGthn5/JVufFStkE/O5IbjumF0MhaR8QljUyxQohDjh7r2a6CfwLKgxR5G4pZqaxMumDnAP9HKvAUIP4rfyknqrwtOaJU4KYxIzOKwKj/Bv0uESnktUt7g5ItH21ikHCUMr8KbAII9nE3oVJixYfHwL4CDoLj/kJArf0VaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GsFpotYB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GsFpotYB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F17AE1F000FF;
	Thu, 24 Sep 2026 00:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790210408;
	bh=I5fr4m5zV1HsbEvg5cpoj9adC8pbGMxGUDeIlmewPaA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GsFpotYB328iRGcLSIV0KOtxbjtU0E4lZg8FC8ydEzp+mPQq/3gSTgBABICu31Irk
	 ZlWgFeLlBRBGsl9VIq2Hnz9tjQfR6q1+1O2FwVFekMcB4AL8T6Ob3Z1SkF8ZOy/5Op
	 7gohvq3hbSRXkhWAsr6Q+gTWuXhfL077sPNgdXD9Si5W6hzmzPpb/ilA4sQbj+N+9j
	 A66l4Lzg3Ul7GDzMXOEUfXvFqU5PuCSs2NgfbHNl0Ev/8kW6FYlHXyuYuwIVDPk4zE
	 IPjviNgfbKP17cxID4qPeNUb+Vn6VsCguEggqwIUC9YwNsgit84Mmw2PGD2CgbxQ7v
	 5CViqO1tQ/EXg==
Date: Thu, 24 Sep 2026 01:40:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: alistair23@gmail.com
Cc: linux-pci@vger.kernel.org, Jonathan.Cameron@huawei.com, djbw@kernel.org,
 rust-for-linux@vger.kernel.org, lukas@wunner.de, alistair@alistair23.me,
 linux-cxl@vger.kernel.org, bhelgaas@google.com, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, gary@garyguo.net, ojeda@kernel.org,
 benno.lossin@proton.me, a.hindborg@kernel.org, wilfred.mallawa@wdc.com,
 tmgross@umich.edu, boqun.feng@gmail.com, bjorn3_gh@protonmail.com,
 alex.gaynor@gmail.com, aliceryhl@google.com, Alistair Francis
 <alistair.francis@wdc.com>
Subject: Re: [PATCH v3 00/21] lib: Rust implementation of SPDM
Message-ID: <20260924014001.328ca0ef@jic23-hlaptop>
In-Reply-To: <20260901010347.2614656-1-alistair.francis@wdc.com>
References: <20260901010347.2614656-1-alistair.francis@wdc.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> 
> qemu-system-x86_64 \
>   -nic none \
>   -object rng-random,filename=/dev/urandom,id=rng0 \
>   -device virtio-rng-pci,rng=rng0 \
>   -drive file=deploy/images/qemux86-64/core-image-pcie-qemux86-64.rootfs.ext4,if=virtio,format=raw \
>   -usb -device usb-tablet -usb -device usb-kbd \
>   -cpu Skylake-Client \
>   -machine q35,i8042=off \
>   -smp 4 -m 2G \
>   -drive file=blknvme,if=none,id=mynvme,format=raw \
>   -device nvme,drive=mynvme,serial=deadbeef,spdm_port=2323,spdm_trans=doe \
>   -snapshot \
>   -serial mon:stdio -serial null -nographic \
>   -kernel deploy/images/qemux86-64/bzImage \
>   -append 'root=/dev/vda rw  console=ttyS0 console=ttyS1 oprofile.timer=1 tsc=reliable no_timer_check rcupdate.rcu_expedited=1 swiotlb=0 '
> 
Looking at this because of discussion about RCiEPs.

For the test I'd do something more realistic and throw in a root port and put your
device on that rather than as currently where I think it'll is presented as
a Root Complex Integrated Endpoint.

You don't want a particularly complex setup for this but those ones in
the qemu tests tend to provide syntax to copy.
I like the HMAT bios table tests
https://elixir.bootlin.com/qemu/v11.1.1/source/tests/qtest/bios-tables-test.c#L2058

And that suggests you want something like:

-device pcie-root-port,chassis=1,id=pci.1"
-device nvme,drive=mynvme,serial=deadbeef,spdm_port=2323,spdm_trans=doe,bus=pci.1"

Then you'll have a normal looking direct connected NVMe pcie express devices.

Shouldn't make any real difference in practice beyond paths changing and it
smelling more normal for something you might want to attest!

