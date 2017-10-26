Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751228AbdJZWhG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Oct 2017 18:37:06 -0400
Received: from localhost (unknown [69.71.4.159])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E7A32191B
        for <linux-pci@vger.kernel.org>; Thu, 26 Oct 2017 22:37:05 +0000 (UTC)
Date: Thu, 26 Oct 2017 17:37:01 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Subject: Make Bjorn's life easier (and grease the path of your patch)
Message-ID: <20171026223701.GA25649@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a list of things I look at when reviewing patches.  Most of
the technical things are obvious or covered elsewhere, so this list is
mostly cosmetic things.  I hesitate to post it because (a) it feels so
trivial, (b) most of these things seem obvious as well, and (c) I
normally clean them up silently in the process of applying patches.

But things that seem obvious to the receiver are not always obvious to
the sender, and I do spend a lot of time on this cleanup.  When I get
patches that need a lot of it, I put off looking at them because I
figure the author didn't really care that much.  So if you *do* care,
and you pay attention to these details, I'm more likely to handle your
patch quickly.


Write the patch:

  - Make each patch small but complete by itself.  It's trivial for me
    to squash patches together if they get *too* small.

  - Make sure the kernel builds after every patch.  You can't
    introduce a problem in one patch and fix it in a subsequent patch.
    If one of the autobuilders finds a build issue, I'll revert the
    patch unless you send a fix.

  - Please send whitespace and coding style fixes, but don't mix them
    with other substantive changes.  It's easier for people to
    backport fixes if whitespace changes are at the end of a series.

  - Wrap code and comments to fit in 80 columns.  Exception: I prefer
    printk strings to be in one piece for searchability, so don't
    split them to make them fit in 80 columns.

  - Follow the existing style for code, names, and indentation.  If I
    can tell that more than one person contributed to the file, you're
    doing something wrong.

Write the changelog title (first line of the changelog):

  - Follow the existing convention, i.e., run "git log --oneline
    <file>" and make yours match in format, capitalization, and
    sentence structure.  For example, native host bridge driver patch
    titles look like this:

      PCI: altera: Fix platform_get_irq() error handling
      PCI: vmd: Remove IRQ affinity so we can allocate more IRQs
      PCI: mediatek: Add MSI support for MT2712 and MT7622
      PCI: rockchip: Remove IRQ domain if probe fails

  - Write a complete sentence, starting with a capitalized verb.

  - Include specific details, e.g., write "Add XYZ controller support"
    instead of "add support for new generation controller".

  - Do not include a trailing period.

Write the changelog:

  - Make the changelog readable without the title.  The changelog is
    not a continuation of the title, so it should make sense by
    itself.

  - Explain the change (not just "Fix this problem"), but do it as
    concisely as possible.  I don't want a book, but I do appreciate
    the function names, spec references, etc. that help a reviewer
    verify the change.

  - Capitalize initialisms ("PCI", "IRQ", "ID", "MSI", etc) in all
    English text, including title, changelog, and comments.

  - Include "()" after function names and "[]" after table array
    names.

  - Include dmesg output and stack trace when relevant.  Prune details
    that aren't relevant, e.g., you can usually remove timestamps and
    function addresses.  The objective is to concisely illustrate the
    issue and make it discoverable by search engines.

  - Remove tabs from the changelog because "git log" indents the
    changelog and things aligned with tabs won't stay aligned.

  - Wrap changelogs to fit in 80 columns when shown by "git show",
    which adds 4 spaces.  I use "textwidth=75" in vim.

  - Order tags as suggested by Ingo [1] (extended):

      Fixes:
      Link:
      Reported-by:
      Tested-by:
      Signed-off-by: (author)
      Signed-off-by: (chain)
      Reviewed-by:
      Acked-by:
      Cc: stable@vger.kernel.org	# 3.4+
      Cc: (other)

  - Include a "Fixes:" reference when you're fixing a previous commit
    and copy the author of the previous commit.  This helps people
    figure out where a change needs to be backported.

  - Include specific commit references when possible, e.g.,
    'e77f847df54c ("PCI: rockchip: Add Rockchip PCIe controller
    support")'.  I use this alias to generate them:

      alias gsr='git --no-pager show -s --abbrev-commit --abbrev=12 --pretty=format:"%h (\"%s\")%n"'

  - Include bugzilla URLs if available (kernel.org bugzilla
    preferred), e.g.,

      Link: https://bugzilla.redhat.com/show_bug.cgi?id=1409201

  - Include problem report URLs (http://lkml.kernel.org/r/ preferred),
    e.g.,

      Link: http://lkml.kernel.org/r/4bcbcbc1-7c79-09f0-5071-bc2f53bf6574@kernel.dk

  - Include specific spec references when possible, e.g., "PCIe r3.1,
    sec 7.8.2".  If you're talking about something mentioned in the
    spec, use the same name and capitalization as the spec.

  - Include a "CC: stable@vger.kernel.org" tag if you want one, and
    indicate which kernels need it.

Post the patch:

  - Copy linux-pci@vger.kernel.org.  I don't apply patches that
    haven't appeared on the mailing list, even if you send them to me
    directly.  This is partly to make sure everyone has a chance to
    review it and partly because I use the Patchwork tracker [2],
    which only sees things on the mailing list.

  - If you send more than one patch and they're related, always
    include a "[0/n]" cover letter.  This makes it easy for me to
    reply saying "I applied this series."  I use "stg -e -v v1
    --to=... patch1..patchN".

  - If you post a new version, please make sure it includes "[v2]" or
    whatever in the subject line.  If it's a series, I want a new
    version of the entire series.  I don't want updates of individual
    patches within the series -- that's too hard to manage.  It's
    perfectly fine if some patches in a v2 series are the same as in
    the initial posting.

  - If you're really gung-ho, you can go to Patchwork [2] and mark
    your superseded patches as "Superseded" so I don't have to do that
    myself.

  - If you want the patch in the current release, include a cover
    letter and tell me that.  Otherwise, I assume all patches are
    intended for the next merge window.

[1] http://lkml.kernel.org/r/20120711080446.GA17713@gmail.com
[2] https://patchwork.ozlabs.org/project/linux-pci/list/
