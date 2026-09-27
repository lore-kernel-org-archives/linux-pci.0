Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406743B95E3;
	Sun, 27 Sep 2026 07:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790493371; cv=none; b=JPrsxhlar9GjPjd7x63C8bI7YaKkJiLOFRQ/Tz1ZwRMWtXDKQ0uJWCUCkP1+IYPzdNU0q6qFVv3LSscb7xeB+hN1F6BJRie3C8VkvwDE3kX1z1fRBzcVNXkAx/1a6NZT1ShQ1hQe9/ORDadjEvcqRzv3cZoT3/IRCVR2SV7ebKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790493371; c=relaxed/simple;
	bh=ICC8nySJqb9ldI86ZOjH95n99gb+KIwD1LDNKiVRGsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D6eJbu2FzIDB0a8lTg9wuIcJUMclanm/ijCCT3KZCQQb9F3W5nilNz0J1LnTqzvBVU/I0UEWE9W+Yb/7yBcw7rLN5hQeQ9UV32zfGTAwLHN4hBZHK/owid0dL1qKr4rKxX+scIQ3tUgufpEeFpdc/V4RK7CMMojRGuzrH07+4Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6vgHxjS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6vgHxjS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 205CA1F000FF;
	Sun, 27 Sep 2026 07:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790493369;
	bh=G6wN4MC6B/I0HCuFhV6PkwNXoUfGqcUvMhsE4frzh5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i6vgHxjSD3uap5KhbRyIP+LGno1A58RjI64ksdqqjNl7xump37HtL8FIxwEeWrTk9
	 uwoCFAfmHxc7R7WjIraaACO885tZv6Zh1TnPgNu/bjJObFR7YnUwtBjjdHQy9qXI+9
	 uTOk+ZAjI2QDb/FFvQO6pqToTDiFjMiqfB/VOvF1UUMqtORqLlCaT/fMsdbOnQaX2U
	 +dcf5ZETLiO3z9aRQYpQ1+HeeZsPBzkvf7YReh2+5/hHcOU58NMWyJotC+fB1EzeYQ
	 /+Tdivc68I81ymxjGkviBuoCrXZUt5Q0flnsboEkFRuaapo94JVS3l4NGbEdcScllx
	 QVVhTnUGT4w5A==
From: Niklas Cassel <cassel@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Cc: Niklas Cassel <cassel@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" <linux-ide@vger.kernel.org>
Subject: Re: (subset) [PATCH v2 0/2] Fix for storage corruption w/ AMD IOMMU on 64-bit addressing
Date: Sun, 27 Sep 2026 09:15:48 +0200
Message-ID: <179049319618.587386.17801056230411978179.b4-ty@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260908190600.226485-1-mario.limonciello@amd.com>
References: <20260908190600.226485-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=777; i=cassel@kernel.org; h=from:subject:message-id; bh=ICC8nySJqb9ldI86ZOjH95n99gb+KIwD1LDNKiVRGsY=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLJ2HFq+y3fvq/Ubk2y1GS82XYk37+ddcd7o9jQtu3sds R0Lf75r7ShlYRDjYpAVU2Tx/eGyv7jbfcpxxTs2MHNYmUCGMHBxCsBEduYwMpyROH032C/5burP 2wqP/jjmt565nqtX7z49L6R3RtwRlXOMDLMOVSTkPFTpk9T9r68e6SG1JfF14Frv5KDnVuEXT1a /YwUA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

On Tue, 08 Sep 2026 14:05:58 -0500, Mario Limonciello wrote:
> An issue has been reported by a number of people that corruption
> was occurring on storage for desktop systems.  It's notably reported
> on SATA, but the same issue also appears on NVME.
> 
> At a glance it looks like an IOMMU issue as turning off the IOMMU helps
> the issue, but it's actually a problem that occurs specifically with any
> IOVA addressed >58 bits.
> 
> [...]


I modified the commit message to reference the PCI quirk which has
now landed in mainline, and thus has a proper SHA1.

Applied to libata/linux.git (for-7.4), thanks!

[2/2] Revert "ata: ahci: force 32-bit DMA for JMicron JMB582/JMB585"
      https://git.kernel.org/libata/linux/c/6b28e0e7

Kind regards,
Niklas
