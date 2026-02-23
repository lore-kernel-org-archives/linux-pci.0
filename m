Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98701EBA14
	for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 18:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771873069; cv=pass; b=srLFDKIbKcQo8TXdpw52SKNLjvqeDiUWJzVwI60Uz/7SwkmMo5QlCymjIlNFvUqUO4CWu7g2Heu+jC7ubwYhRWaIo80btvWPBFbQFVIC+DtdqWOmwAGgWoY4WjT2S4zLlk9gNX1x8Qd/mQ4glCbN9VrGoDdL5pyIx8dHeGTM+ds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771873069; c=relaxed/simple;
	bh=OFD6NUQfqB5lbYiIMDtP4O+JDI3QL0PIMq1HidCRagY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F6jwTOe/O5MUkiQGjxley3U9bsaOA4M/iTXAyaagQZtsevWfN4GR1/cIkj73sVZt3a/rBGGS2vwxyNCypWBqFRPNuW5OkDArJ/DvTY17INzUYKC/RJfw3mAwHSBoCD7/f5LQzavDB9vr128Zl5FbmFnX39EWOrNPH0rgxGcubow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KkN7aB0L; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KkN7aB0L"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-387097ae2e3so39232421fa.2
        for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 10:57:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771873067; cv=none;
        d=google.com; s=arc-20240605;
        b=EdHQejmqJx9ahwwEn4pptXBE5dZVPQGbniq73KPEPSbmWiwRrq7Qdvt+ulo8m4mN9b
         4eDyqBQBYe/eTONSgYby1X2qQsiFckGsAreBzQre6EZxbj52BlI/MZ2/cHTQ6t70hR0m
         XY52UvyBPFOuEVSEAcRh2I0bJ7hIvoGc1miQDQDyTtlm0qNmBgA38h1Myz4dooE02nFw
         Bw5QtCYqGR5forksgHAY+AYMdJkfModpRI0W4nUiMB5XEVEkYVnKEbCGkEloUjXQeDKM
         hcwGLYycReNTw5MyUUvE3EYRfMrFJads+NiiGlO8rxb43dDj6QxMVuLCsCZcUVqGd/ba
         zMqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f/DOHd9CpHSCbT+LNTCI9j3eLuodht0W+GmwsJ9Rdho=;
        fh=JD8W6z5dCor50T9z1laT69Fe/wPSZtXgOlogUaHXjd8=;
        b=B6YbxbyVohkq4Hr5FFyJ6wKtXlaOQAesTUjzak3TcZh8lTjOL7xZMcER/m0IQR5nIn
         py2qqM1Z5XETC/kx4yUdfoeRDazNeLpjF/3n11Ugxhn/LpSulp67dnPOOvPeu84qvFQj
         mnG8dh3dYq/DqeSfVmBk3UueYOVe8GNR06I1kcdAGdMmhJXTWEl2dffizXw2ose1m3GI
         Jh3yYE66b12UFHQ+4xaCkwM+GS2NdgUKXj2j1wyrxzd5WoDlNB5L96owzDydIlo9jw4M
         wqZ6JyAa21qz7r3w4dcezneEz2q3B4X/dPhLgmkIjSCOGq6aX0a/1SPZQDPY0A+WOhb6
         jttQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771873067; x=1772477867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/DOHd9CpHSCbT+LNTCI9j3eLuodht0W+GmwsJ9Rdho=;
        b=KkN7aB0Lm3o5t+ZSRyBfZCwkma3MzZHGLYKLC36yHNQfJiI5wpk1Ebkyz9jk+gK2MQ
         Qf1jGp0KESdGIUmpXX4nzYyHJt8wNbTeckQKRSOHwIEXpjI7zJFIkkWWVudo49IaawY1
         /pdlkJQiytGHkPIWQ5kW/H76sAnLRFyR8J2tmBcCLJ/5JUdA9CUxiB0uhlDnRl0tcDxs
         80x0uy358sFit2bPsyblqtxmS03qFlpXXBoHyaCVYuis5P1C2Vt2KaXbXmcwTXs+q4Az
         rzXo43SEALJz2uwCR2vfeFOz9zPDshzzJ4MKOHKdREsfqEZ+5GBoiY0JBijA/gKn6ot4
         p4Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771873067; x=1772477867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f/DOHd9CpHSCbT+LNTCI9j3eLuodht0W+GmwsJ9Rdho=;
        b=QF58MhTvcKBXKD4Io5BVcIGkXbGG8oMu9YZiJQe9naQG9e7WD1FlpGok6BGVLcNBHm
         gC3wfijBrtZw3g9HxFcn26C5eWtaQq15afpr1sKfNRvi9S1D1CTr/OOYdPv8as5F043r
         5y0JrTaWXS+NBwb1vOhmmP6vB+u9FixuMsmzrSuNcg7ro+gnMqVAyGPpO8tMskuMrofj
         Z1a+yfnz+x28FMfJpVoBkF52sS6gOZPpC/tcfxERBAoUYLmwhc+0qSSiZjbfwmhLeyc9
         lQb9MnwniKrXhEGewO4oI/9CW8iQjKWmlKJUf/BGEQrIPAbp0oHQxXpSWziqHB6ejQkA
         vrrA==
X-Forwarded-Encrypted: i=1; AJvYcCVPx2VjPWKyaqeig1hrkhW9B+rO6WujOsq7qG2XDzX4afBdUTYF9DKdRKqG6M8bitOXK7fi7ZMpdQw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0rGQOK4WFKyUWMcQqjEh//UZpTfn53ukcra629REAAGM8YYq8
	yIMhRpcq654c0fqHsP6ZTCnfvgvfHbHsF6jnXCAm3SeGV4zjs0jM1+KawK/S+lSJWZgmS/Cc7hr
	vjVvwIhZZOUHJNdaWhFshvJNz5EN4dhtt0KsDqpdkY6k9CdfpRwF/vbDjl7I=
X-Gm-Gg: ATEYQzxr3q233ggsDHNj7pwar9vJxswLcgGDpLfSl70td79r3ms8k7AllMVwN9K2vaO
	jFa0Ou41UXGZVqDEbunehvPfQMOgsNqk9pSe1dc96JfqCL9f40xN7+S0GXPxXU+iNgzglVEBUHo
	D0ErGI6Kr6Ec/D7kZbF+vS0oZ+N+dhekpaK0s4ecG2hbf5ew6acfNesy+057/RWA38M6VNmqSYB
	M5Tsv5ptLEKpoB4Vgla3Rpdp+vL7sK79m+dJXLvSHUYnLrxTou+VXu52vHikwMZD1A3bnpydQiI
	FSSU/IZcaPmJTqWtqw==
X-Received: by 2002:a05:651c:41c7:b0:383:1b4b:c2c8 with SMTP id
 38308e7fff4ca-389a5e8e30bmr24927701fa.41.1771873066594; Mon, 23 Feb 2026
 10:57:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251210181417.3677674-1-rananta@google.com> <20251210181417.3677674-7-rananta@google.com>
 <aUSNoBzvybi24SUD@google.com> <CAJHc60zAB8pyc7=ca=eOf+SEEvnZ3JxVEnZoOtgj+mX1GQiALw@mail.gmail.com>
 <aYUQ_HkDJU9kjsUl@google.com>
In-Reply-To: <aYUQ_HkDJU9kjsUl@google.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 23 Feb 2026 10:57:18 -0800
X-Gm-Features: AaiRm51xsX0sj5UKMqLZlpyRZUJezvA_WLsNNCIJwPOLAaI4oJzjAEfrZMVWw2o
Message-ID: <CALzav=fBjW5zN+oOc61ZB69N1dRPFEuYJH=YsD9jYmqwXkKeAA@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] vfio: selftests: Add tests to validate SR-IOV UAPI
To: Raghavendra Rao Ananta <rananta@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Alex Williamson <alex.williamson@redhat.com>, 
	Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 1:52=E2=80=AFPM David Matlack <dmatlack@google.com> =
wrote:
> On 2026-01-06 11:47 AM, Raghavendra Rao Ananta wrote:
> > On Thu, Dec 18, 2025 at 3:26=E2=80=AFPM David Matlack <dmatlack@google.=
com> wrote:
> > > [  574.857650][T27935] BUG: kernel NULL pointer dereference, address:=
 0000000000000008
...
> > > [  575.009753][T27935] Call Trace:
> > > [  575.012919][T27935]  <TASK>
> > > [  575.015730][T27935]  intel_iommu_probe_device+0x4c9/0x7b0
> > > [  575.021153][T27935]  __iommu_probe_device+0x101/0x4c0
> > > [  575.026231][T27935]  iommu_bus_notifier+0x37/0x100
> > > [  575.031046][T27935]  blocking_notifier_call_chain+0x53/0xd0
> > > [  575.036634][T27935]  bus_notify+0x99/0xc0
> > > [  575.040666][T27935]  device_add+0x252/0x470
> > > [  575.044872][T27935]  pci_device_add+0x414/0x5c0
> > > [  575.049429][T27935]  pci_iov_add_virtfn+0x2f2/0x3e0
> > > [  575.054326][T27935]  sriov_add_vfs+0x33/0x70
> > > [  575.058613][T27935]  sriov_enable+0x2fc/0x490
> > > [  575.062992][T27935]  vfio_pci_core_sriov_configure+0x16c/0x210
> > > [  575.068843][T27935]  sriov_numvfs_store+0xc4/0x190
> > > [  575.073652][T27935]  kernfs_fop_write_iter+0xfe/0x180
> > > [  575.078724][T27935]  vfs_write+0x2d0/0x430
> > > [  575.082846][T27935]  ksys_write+0x7f/0x100
> > > [  575.086965][T27935]  do_syscall_64+0x6f/0x940
> > > [  575.091339][T27935]  ? arch_exit_to_user_mode_prepare+0x9/0xb0
> > > [  575.097193][T27935]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> I think this is a use-after-free.

Fix proposed here:
https://lore.kernel.org/linux-pci/20260223184017.688212-1-dmatlack@google.c=
om/
