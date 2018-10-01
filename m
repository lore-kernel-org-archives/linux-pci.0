Return-Path: <SRS0=/qR3=MN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6260EC43143
	for <linux-pci@archiver.kernel.org>; Mon,  1 Oct 2018 18:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E9EB2145D
	for <linux-pci@archiver.kernel.org>; Mon,  1 Oct 2018 18:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pjdwGQVW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E9EB2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbeJBBdZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Oct 2018 21:33:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbeJBBdZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Oct 2018 21:33:25 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DB972089A;
        Mon,  1 Oct 2018 18:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538420055;
        bh=9p+rovX+Wa+Fyv135tJytouTHlGVWvcR6oYsgyXpZyQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pjdwGQVW9Zr/n3XGFArxq5MyXs/jJbH864V5//KWJpgkrSj3aRACwaKUWcGNroBkE
         hEyB/70hJOAUmT2L4rPU4JweMqKx11XeP+x06WynzNMUfL6zxl66uXX4AG8ZCf11Ak
         SGKFAw2ZK/3jOkYjd76IMXFrpJCvgeFK+/SPn7uU=
Date:   Mon, 1 Oct 2018 13:54:13 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <keith.busch@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>, linux-pci@vger.kernel.org
Subject: Re: Bad MAINTAINERS pattern in section 'ACPI'
Message-ID: <20181001185413.GB142872@bhelgaas-glaptop.roam.corp.google.com>
References: <20180928215054.28561-1-joe@perches.com>
 <20180928230616.GA150287@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180928230616.GA150287@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 28, 2018 at 06:06:17PM -0500, Bjorn Helgaas wrote:
> [+cc Tony, Borislav (ACPI APEI reviewers), linux-pci]
> 
> On Fri, Sep 28, 2018 at 02:50:53PM -0700, Joe Perches wrote:
> > Please fix this defect appropriately.
> > 
> > linux-next MAINTAINERS section:
> > 
> > 	308	ACPI
> > 	309	M:	"Rafael J. Wysocki" <rjw@rjwysocki.net>
> > 	310	M:	Len Brown <lenb@kernel.org>
> > 	311	L:	linux-acpi@vger.kernel.org
> > 	312	W:	https://01.org/linux-acpi
> > 	313	Q:	https://patchwork.kernel.org/project/linux-acpi/list/
> > 	314	T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
> > 	315	B:	https://bugzilla.kernel.org
> > 	316	S:	Supported
> > 	317	F:	drivers/acpi/
> > 	318	F:	drivers/pnp/pnpacpi/
> > 	319	F:	include/linux/acpi.h
> > 	320	F:	include/linux/fwnode.h
> > 	321	F:	include/acpi/
> > 	322	F:	Documentation/acpi/
> > 	323	F:	Documentation/ABI/testing/sysfs-bus-acpi
> > 	324	F:	Documentation/ABI/testing/configfs-acpi
> > 	325	F:	drivers/pci/*acpi*
> > 	326	F:	drivers/pci/*/*acpi*
> > -->	327	F:	drivers/pci/*/*/*acpi*
> > 	328	F:	tools/power/acpi/
> 
> My proposal to fix this:
> 
> commit a99051c0d3c59fd259fd76a8bbd9837b76b509d9
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Fri Sep 28 17:34:21 2018 -0500
> 
>     MAINTAINERS: Remove obsolete drivers/pci pattern from ACPI section
>     
>     Prior to 256a45937093 ("PCI/AER: Squash aerdrv_acpi.c into aerdrv.c"),
>     drivers/pci/pcie/aer/aerdrv_acpi.c contained code to parse the ACPI HEST
>     table.  That code now lives in drivers/pci/pcie/aer.c.
>     
>     Remove the "F: drivers/pci/*/*/*acpi*" pattern because it matches nothing.
>     
>     We could add a "F: drivers/pci/pcie/aer.c" pattern to the ACPI APEI
>     section, but that file sees a lot of changes, almost none of which are of
>     interest to the ACPI folks.
>     
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 700408b7bc53..9babd8a0406b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -324,7 +324,6 @@ F:	Documentation/ABI/testing/sysfs-bus-acpi
>  F:	Documentation/ABI/testing/configfs-acpi
>  F:	drivers/pci/*acpi*
>  F:	drivers/pci/*/*acpi*
> -F:	drivers/pci/*/*/*acpi*
>  F:	tools/power/acpi/
>  
>  ACPI APEI

Applied with Rafael's ack to for-linus for v4.19.
