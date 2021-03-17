Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91521C433E6
	for <linux-pci@archiver.kernel.org>; Wed, 17 Mar 2021 12:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46EBC64F41
	for <linux-pci@archiver.kernel.org>; Wed, 17 Mar 2021 12:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhCQMYY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Mar 2021 08:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhCQMYE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Mar 2021 08:24:04 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2154EC06174A;
        Wed, 17 Mar 2021 05:24:04 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4F0q8H4Kc9z9sWP; Wed, 17 Mar 2021 23:23:59 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Tyrel Datwyler <tyreld@linux.ibm.com>, bhelgaas@google.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210315214821.452959-1-tyreld@linux.ibm.com>
References: <20210315214821.452959-1-tyreld@linux.ibm.com>
Subject: Re: [PATCH v2] rpadlpar: fix potential drc_name corruption in store functions
Message-Id: <161598380341.805135.1994223786629407257.b4-ty@ellerman.id.au>
Date:   Wed, 17 Mar 2021 23:23:23 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 15 Mar 2021 15:48:21 -0600, Tyrel Datwyler wrote:
> Both add_slot_store() and remove_slot_store() try to fix up the drc_name
> copied from the store buffer by placing a NULL terminator at nbyte + 1
> or in place of a '\n' if present. However, the static buffer that we
> copy the drc_name data into is not zeored and can contain anything past
> the n-th byte. This is problematic if a '\n' byte appears in that buffer
> after nbytes and the string copied into the store buffer was not NULL
> terminated to start with as the strchr() search for a '\n' byte will mark
> this incorrectly as the end of the drc_name string resulting in a drc_name
> string that contains garbage data after the n-th byte. The following
> debugging shows an example of the drmgr utility writing "PHB 4543" to
> the add_slot sysfs attribute, but add_slot_store logging a corrupted
> string value.
> 
> [...]

Applied to powerpc/fixes.

[1/1] rpadlpar: fix potential drc_name corruption in store functions
      https://git.kernel.org/powerpc/c/cc7a0bb058b85ea03db87169c60c7cfdd5d34678

cheers
