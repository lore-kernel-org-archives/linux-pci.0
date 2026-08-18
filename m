Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF94339B41;
	Tue, 18 Aug 2026 22:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787092159; cv=none; b=Tg5ipp/mvZkieHYTMB91qLVs+p4EOp8ph4bdkBcIQlFwlXn0HUy9e6dpbvpNAaw9D3OSHABkdqaQaTYWELiXLtU4y42zrfhHo1bMdYugVMpSBl4r51gHJiwg4VJNJPgEMDaE27WGgB29KUsIZynHrIrbWXlzFv7oMxz5cW9A1yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787092159; c=relaxed/simple;
	bh=odmkh72lFaNg8G/VukTZuHrhHtWKSFkdJXrBASa2NXk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Viq0Tsabj5BygHs49kFLpD8Ykiq46HNMDt7d1rauwonGA8nwZYL3HbLddgMNwIzNcf9aVJgpH6cLM7P2aUaqFQVUqIKCtDUI/cLWomjoQQ07rEqZxMe0qNqeqruSwZsQyY8kmrQYhf53W89uAfk/XJjM+OMt+lWXx2o+QiAVF6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oX0LP5KB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oX0LP5KB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB8E1F000E9;
	Tue, 18 Aug 2026 22:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787092157;
	bh=kBALQoYUq6yWQKPtfx2Gz4f6SRuObdrAjEoQaeEeBhY=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=oX0LP5KBV6tqI4smvI4IAnZ5naFQqe+b3buPIYK65c/Oxnd5aFUMTQbzOfe6Xi6UD
	 6/07GGPUSHMBRxplJ8GbZEEhdkY5VLfU3sZyItD0JSBH+eAbQcZPQUn5PT9dsUmySf
	 4HKGdWlsjsB1CzEOyNxpBeJg8Htih4PJmziVHS8p06Yd0GbjgYgevqe/lX/ABYuV/8
	 ekXBZHGrVK9wp8bQHbj4M4PRYe01dgZgQvjCqJEOU3A/JLg6tWuSxj07i5Dj8jFxf0
	 +4d4ZNrNHqJncbhPjA7U/4ptlNwyVUwNglXw6aNIHHCxu0LWG9RbRHrwy7wdBj/+DJ
	 BHJragxnY874g==
Date: Tue, 18 Aug 2026 17:29:16 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Priyank Rathod <rathodpriyank@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4] PCI/pcie: Add PCIe Lane Margining at Receiver (LMR)
 support
Message-ID: <20260818222916.GA747146@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260818-pcie-lmt-v4-1-eb17a6d755fa@google.com>

On Tue, Aug 18, 2026 at 09:20:24PM +0000, Priyank Rathod wrote:
> Per PCIe Base Specification r6.0, sec 8.4.4 ("Lane Margining at
> Receiver"), PCIe devices operating at 16.0 GT/s (Gen 4) or higher data
> rates support the Lane Margining at Receiver Extended Capability
> (ID 0x27), and it is mandatory for receivers operating at 64.0 GT/s
> (Gen 6) or higher data rates. Lane Margining allows software to
> evaluate high-speed link margins by measuring timing and voltage steps
> for each individual physical lane and receiver.

  Aug 18 13:57 Priyank Rathod  [PATCH] PCI/pcie: Add PCIe Lane ...
  Aug 18 14:26 Priyank Rathod  ├─>[PATCH v2] PCI/pcie: Add PCIe Lane ...
  Aug 18 15:49 Priyank Rathod  ├─>[PATCH v3] PCI/pcie: Add PCIe Lane ...
  Aug 18 16:20 Priyank Rathod  └─>[PATCH v4] PCI/pcie: Add PCIe Lane ...

No need to rush:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=v7.2#n361

The v7.3 merge window is open now, so this is likely v7.4 material.
