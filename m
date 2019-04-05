Return-Path: <SRS0=e3W/=SH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FAFC282CE
	for <linux-pci@archiver.kernel.org>; Fri,  5 Apr 2019 22:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3480321855
	for <linux-pci@archiver.kernel.org>; Fri,  5 Apr 2019 22:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554503587;
	bh=7ewTkUrqrMaQHlGYWysY7oJ/SHY7xljwl2B1977CleM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hYPhvvU6yqPbmdQ/lgoG7NlloRM6KYzgOuIXo+awuE2jvOi9YAbdz7KUSvpy5SS4t
	 1TPD2srYJIsf/6Oj3N/EYv0SyWcMZxBSLsYWoUx/Pr7goOX/BpUy4BG1vWy+PdTMda
	 XejfTMOTeHI7002K+7LuknJ4gwqEHUxkMJaH29Xo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbfDEWdG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 5 Apr 2019 18:33:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:43956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbfDEWdG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Apr 2019 18:33:06 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A50E206BA;
        Fri,  5 Apr 2019 22:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554503585;
        bh=7ewTkUrqrMaQHlGYWysY7oJ/SHY7xljwl2B1977CleM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wfb9xaK30k1/3jfyuQBOTjYOhImWlvC5UntBiFIzFp5MzsyZ1fn8X89vb4D6zkIKI
         DXHZ3Ka+W3iEf9w+9saGyJOZKv0XIbRLeXKkyEg5koIrppqBaP7dpAGgZmM8TjRcXA
         0d1+0P4smvLp2DSjMoGBVKjwDFqs8AlPHFEbuT6o=
Date:   Fri, 5 Apr 2019 17:33:00 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pierre =?iso-8859-1?Q?Cr=E9gut?= <pierre.cregut@orange.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/IOV: update num_VFs earlier
Message-ID: <20190405223300.GD159318@google.com>
References: <20190329080058.21736-1-pierre.cregut@orange.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190329080058.21736-1-pierre.cregut@orange.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 29, 2019 at 09:00:58AM +0100, Pierre Crégut wrote:
> Ensure that iov->num_VFs is set before a netlink message is sent
> when the number of VFs is changed. Only the path for num_VFs > 0
> is affected. The path for num_VFs = 0 is already correct.
> 
> Monitoring programs can relie on netlink messages to track interface
> change and query their state in /sys. But when sriov_numvfs is set to a
> positive value, the netlink message is sent before the value is available
> in sysfs. The value read after the message is received is always zero.

Thanks, Pierre!  Can you clue me in on where exactly the connection
from sriov_enable() to netlink is?

I see one side of the race is with sriov_numvfs_show(), but I don't
know where the netlink message is sent.  Is that connected with the
kobject_uevent(KOBJ_CHANGE)?

One thing this would help with is figuring out exactly how *much*
earlier we need to set iov->num_VFs.  It looks like the current patch
sets it before we actually enable the VFs, so a user could read
/sys/.../sriov_numvfs and get the wrong value.  Of course, that's
unavoidable; the question is whether it's OK to get the new value
*before* it actually takes effect, or whether we want to return a
stale value until after it takes effect.

> Link: https://bugzilla.kernel.org/show_bug.cgi?id=202991
> Signed-off-by: Pierre Crégut <pierre.cregut@orange.com>
> ---
> note: the behaviour can be tested with the following shell script also
> available on the bugzilla (d being the phy device name):
> 
> ip monitor dev $d | grep --line-buffered "^[0-9]*:" | \
> while read line; do cat /sys/class/net/$d/device/sriov_numvfs; done
> 
>  drivers/pci/iov.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 3aa115ed3a65..a9655c10e87f 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -351,6 +351,7 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
>  		goto err_pcibios;
>  	}
>  
> +	iov->num_VFs = nr_virtfn;
>  	pci_iov_set_numvfs(dev, nr_virtfn);
>  	iov->ctrl |= PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE;
>  	pci_cfg_access_lock(dev);
> @@ -363,7 +364,6 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
>  		goto err_pcibios;
>  
>  	kobject_uevent(&dev->dev.kobj, KOBJ_CHANGE);
> -	iov->num_VFs = nr_virtfn;
>  
>  	return 0;
>  
> @@ -379,6 +379,7 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
>  	if (iov->link != dev->devfn)
>  		sysfs_remove_link(&dev->dev.kobj, "dep_link");
>  
> +	iov->num_VFs = 0;
>  	pci_iov_set_numvfs(dev, 0);
>  	return rc;
>  }
> -- 
> 2.17.1
> 
