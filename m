Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92413112A1;
	Mon, 26 Jan 2026 07:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769414369; cv=none; b=JXum4GACqaWmjufXlRJqk9dhMsqYM0SjOS2cREAm+Acq5Q2rSMXlAbjJXMXPkt1F5HapcL0pLTC5AUYsuZIAC5LZ1avSvz3cfRmeosKHFvB8rEAJYihigPcGitNOxG9VPZJ0y51T4eASbFdh1gCo8v6cwUbkkEyKkNNrd3shUOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769414369; c=relaxed/simple;
	bh=J50tdSk8sDMdjw4n+Da8atfv3eIp+GRNj2176vLLWCM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fbuqhjkJyqRZASSy+A5eTBbZJcvwyB+jC9nWYrPixUW5SjYSiO4/EPBxkxBen1L/kMcrI0ubCd7zQbbweFmAkGkhte+6ubACIf0fGY/Q3CCn6RIhduDwt8BVzZsIb5KhTnn+HQZSY5RAkFt3rGKqeDnyq4Pd1MBjQdVy8+3MFR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGcUjlqe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGcUjlqe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F0DBC116C6;
	Mon, 26 Jan 2026 07:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769414369;
	bh=J50tdSk8sDMdjw4n+Da8atfv3eIp+GRNj2176vLLWCM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=IGcUjlqeD/uHIpcJBQqTX4/l3rJ/PjKgJ9PQCAvbyq1M7GiZJfmlQ1uZKVW8tefw0
	 O5AHUG80x8L/1Ra2LMSzvil5LZKpalBgolJsTYZ3Yk30/KCwPs57eIlhGIviOJ0cbd
	 /qUXVuXH6vGSXAyoxS+1AJCBolWQsaM04J0ci1VJKSuon3jQcaPTeNpB2qlGpH2uS7
	 l75SPdn9kVNljbev0O3fMHqEq1UW1GzKd9viTd8uWqd1DRJ2q1hGGhRchdNcuzVTAo
	 ox6DMgFXxsOvcO8XCT8OWDd3H12v9CD3ibdJu3hqBvQROfT5rQy0+hda9CZejv1Jv5
	 g2mnY164ejYcg==
From: Thomas Gleixner <tglx@kernel.org>
To: Radu Rendec <rrendec@redhat.com>, Jon Hunter <jonathanh@nvidia.com>,
 Manivannan Sadhasivam <mani@kernel.org>
Cc: Daniel Tsai <danielsftsai@google.com>, Marek =?utf-8?Q?Beh=C3=BAn?=
 <kabel@kernel.org>,
 Krishna Chaitanya Chundru <quic_krichai@quicinc.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, Krzysztof
 =?utf-8?Q?Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, Brian
 Masney <bmasney@redhat.com>, Eric Chanudet <echanude@redhat.com>,
 Alessandro Carminati <acarmina@redhat.com>, Jared Kangas
 <jkangas@redhat.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, "linux-tegra@vger.kernel.org"
 <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] PCI: dwc: Enable MSI affinity support
In-Reply-To: <96c9d483f67be02fa1dba736fea465216d0c3269.camel@redhat.com>
References: <20251128212055.1409093-1-rrendec@redhat.com>
 <20251128212055.1409093-4-rrendec@redhat.com>
 <4e5b349c-6599-4871-9e3b-e10352ae0ca0@nvidia.com>
 <a8d841e870d6dbbabef7eadb774f2a58a96c57c7.camel@redhat.com>
 <cfe44924-3419-4f31-8ab3-87b769d21a5b@nvidia.com>
 <96c9d483f67be02fa1dba736fea465216d0c3269.camel@redhat.com>
Date: Mon, 26 Jan 2026 08:59:25 +0100
Message-ID: <87sebsdcte.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jan 22 2026 at 18:31, Radu Rendec wrote:
> The CPUs are taken offline one by one, starting with CPU 7. The code in
> question runs on the dying CPU, and with hardware interrupts disabled
> on all CPUs. The (simplified) call stack looks like this:
>
> irq_migrate_all_off_this_cpu
>   for_each_active_irq
>     migrate_one_irq
>       irq_do_set_affinity
>         irq_chip_redirect_set_affinity (via chip->irq_set_affinity)
>
> The debug patch I gave you adds:
>  * a printk to irq_chip_redirect_set_affinity (which is very small)
>  * a printk at the beginning of migrate_one_irq
>
> Also, the call to irq_do_set_affinity is almost the last thing that
> happens in migrate_one_irq, and that for_each_active_irq loop is quite
> small too. So, there isn't much happening between the printk in
> irq_chip_redirect_set_affinity for the msi irq (which we do see in the
> log) and the printk in migrate_one_irq for the next irq (which we don't
> see).

This doesn't make any sense at all. irq_chip_redirect_set_affinity() is
only accessing interrupt descriptor associated memory and the new
redirection CPU is the same as the previous one as the mask changes from
0xff to 0x7f and therefore cpumask_first() yields 0 in both cases.

According to the provided dmesg, this happens on linux-next.

Jon, can you please validate that this happens as well on

     git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/msi

Thanks

        tglx
