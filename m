Return-Path: <SRS0=ZPBx=RJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDFFC43381
	for <linux-pci@archiver.kernel.org>; Wed,  6 Mar 2019 01:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 536A220663
	for <linux-pci@archiver.kernel.org>; Wed,  6 Mar 2019 01:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tkzPR0kc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfCFBY3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 5 Mar 2019 20:24:29 -0500
Received: from mail-lf1-f47.google.com ([209.85.167.47]:35366 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfCFBY2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Mar 2019 20:24:28 -0500
Received: by mail-lf1-f47.google.com with SMTP id h6so3399174lfc.2;
        Tue, 05 Mar 2019 17:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8QKmj3tuAVW/vMcu2vwEMV1qMd0CttNzePa9ZtAlncU=;
        b=tkzPR0kcNNNHbY/fI9BOPQBG5Iccq+iCfd2Cyg0jSHE+89jSYj9zXTkVT/ULflfYvq
         v6EX9SZpDBSFbdOZoxP9y8HpwWbBKUl/uKX23Bk9+3pPfzCa3utV8xdR2q5+ttrU9e00
         u1+qmZb31r/fl70JMhBMXtAFVwQwB9hl38OLagUW1jFbgu3zyytbvC5Y0IrYXNNEGAxS
         A4j3Kvdmn9BQfmcj7p97fJfENF1+2t3PoT55xDIuFtemseE33jW5J2NTfFsrYthW2oki
         k3lyl1VeDg3xa7avcYsclhGJQrr6h86wD80OW4VJ7eNAUdUQD3tijYmCTU0ZF6IhrwEG
         5nHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=8QKmj3tuAVW/vMcu2vwEMV1qMd0CttNzePa9ZtAlncU=;
        b=T8/C1kfgaukcvKWudu8f7pnSdNMYLfgTKNNDTiOfJ7uqmu2Z7HHZxEJScFFedRDpe7
         rPRPRF6CmzucEKYWtM2pht70R7ExvG9YEKCl7AJG1TNcZNmNeIhzI2GxRfogIXZSuhrR
         vTMjsfupeiY23If43z++NK31prOPqWNY97aXfd4ocXVtopcaACIdXrfxwmdoa1kW+/rz
         /tII0fd0fE6BqhOHCAIJFbMGleD9ss5sbtnTTIVMgEzLjh+8a6ON6SPe8r3mS6M/NNU7
         /V+IdRfXKcNTQWXB3ZALYCOPQOWbof7tcp0oxPLoT5A1V2isrw3nWORGeEWdjDk9+Eky
         u27w==
X-Gm-Message-State: APjAAAWYIzrkOXMcgRs4a4zFcOvCcBckjhVo2LfVaWl5+VA3ZM4G2Aqe
        zpBdJ81e5G46xwKRgPSaBWQ=
X-Google-Smtp-Source: APXvYqwBZTaOJTsgJlXxs0HWSi0bMCt+ks7bjCufuR4L0C50In4R2tEYCyVMVRQQY2VbIVM1iDzdtg==
X-Received: by 2002:a19:2c52:: with SMTP id s79mr2374256lfs.32.1551835465195;
        Tue, 05 Mar 2019 17:24:25 -0800 (PST)
Received: from mobilestation ([95.79.187.182])
        by smtp.gmail.com with ESMTPSA id j64sm27938lfg.42.2019.03.05.17.24.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 05 Mar 2019 17:24:24 -0800 (PST)
Date:   Wed, 6 Mar 2019 04:24:22 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kselftest@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Allen Hubbe <allenbh@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Eric Pilmore <epilmore@gigaio.com>
Subject: Re: [PATCH v2 07/12] NTB: Introduce functions to calculate
 multi-port resource index
Message-ID: <20190306012420.wjeatxgb7nwq3j5q@mobilestation>
Mail-Followup-To: Serge Semin <fancer.lancer@gmail.com>,
        Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
        linux-ntb@googlegroups.com, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
        Jon Mason <jdmason@kudzu.us>, Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <joro@8bytes.org>, Allen Hubbe <allenbh@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Eric Pilmore <epilmore@gigaio.com>
References: <20190213175454.7506-1-logang@deltatee.com>
 <20190213175454.7506-8-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213175454.7506-8-logang@deltatee.com>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 13, 2019 at 10:54:49AM -0700, Logan Gunthorpe wrote:

Hi

> When using multi-ports each port uses resources (dbs, msgs, mws, etc)
> on every other port. Creating a mapping for these resources such that
> each port has a corresponding resource on every other port is a bit
> tricky.
> 
> Introduce the ntb_peer_resource_idx() function for this purpose.
> It returns the peer resource number that will correspond with the
> local peer index on the remote peer.
> 
> Also, introduce ntb_peer_highest_mw_idx() which will use
> ntb_peer_resource_idx() but return the MW index starting with the
> highest index and working down.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Cc: Jon Mason <jdmason@kudzu.us>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Allen Hubbe <allenbh@gmail.com>
> ---
>  include/linux/ntb.h | 70 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
> 
> diff --git a/include/linux/ntb.h b/include/linux/ntb.h
> index 181d16601dd9..f5c69d853489 100644
> --- a/include/linux/ntb.h
> +++ b/include/linux/ntb.h
> @@ -1502,4 +1502,74 @@ static inline int ntb_peer_msg_write(struct ntb_dev *ntb, int pidx, int midx,
>  	return ntb->ops->peer_msg_write(ntb, pidx, midx, msg);
>  }
>  
> +/**
> + * ntb_peer_resource_idx() - get a resource index for a given peer idx
> + * @ntb:	NTB device context.
> + * @pidx:	Peer port index.
> + *
> + * When constructing a graph of peers, each remote peer must use a different
> + * resource index (mw, doorbell, etc) to communicate with each other
> + * peer.
> + *
> + * In a two peer system, this function should always return 0 such that
> + * resource 0 points to the remote peer on both ports.
> + *
> + * In a 5 peer system, this function will return the following matrix
> + *
> + * pidx \ port    0    1    2    3    4
> + * 0              0    0    1    2    3
> + * 1              0    1    2    3    4
> + * 2              0    1    2    3    4
> + * 3              0    1    2    3    4
> + *

This table is too simplified to represent a generic case of port-index
mapping table. In particular the IDT PCIe switch got it ports numbered
with uneven integers like: 0 2 4 6 8 12 16 20 or 0 8 16, and so on.
Moreover some of the ports might be disabled or may have NTB functions
deactivated, in which case these ports shouldn't be considered by NTB subsystem
at all. Basically we may have any increasing subset of that port
numbers depending on the current IDT PCIe-switch ports setup.

What I am trying to say by this is that if in real life the NTB MSI library
or some other library used that matrix to calculate the MW index, then most
likely it would either consume nearly all the MWs leaving holes in the space
of MWs or just run out of them since depending on the configuration there might
be from 0 to 24 MWs enabled in a IDT NTB function. In order to solve the problem
we either need the ntb_peer_resource_idx() method somehow fixed so it would use
the pidx instead of the pure port number or we should properly alter the current
NTB API port-index table implementation, so the ntb_pingpong, NTB MSI library and
others wouldn't need to a have some other table to distribute the NTB
resources.

A short preamble of why we introduced the ports-index NTB API. Since each
NTB MW and NTB message registers can be setup to be related with any NTB
device port, we needed to have the port attribute accepted by NTB API
functions. But it turned out the IDT PCIe switch ports are unevenly numbered,
which may cause difficulties in using their numbers for bulk configurations.
So in order to simplify a client code utilizing the multi-ports NTB API (for
example for simpler looping around the device ports), we decided to create the
ports-index table in the NTB API internals. The table is defined by a set of
ntb_port_*()/ntb_peer_port_*() functions. So now all the NTB API methods accept
a port index instead of an irregular port number.

Here is the port-index table currently defined for IDT 89HPES32NT8 PCIe-switch
with all 8 ports having NTB functions enabled:

peer port \ local port   0  2  4  6  8  12  16  20
        0                x  0  0  0  0   0   0   0
        2                0  x  1  1  1   1   1   1
        4                1  1  x  2  2   2   2   2
        6                2  2  2  x  3   3   3   3
        8                3  3  3  3  x   4   4   4
       12                4  4  4  4  4   x   5   5
       16                5  5  5  5  5   5   x   6
       20                6  6  6  6  6   6   6   x

As you can see currently each NTB device side's got its own port-index
mapping, so each port can access another ports, but not itself.
I implemented it this way intentionally for two reasons:
1) I don't think anyone ever would need to have MW or Message registers
setup pointing to the local port.
2) IDT PCIe switch will report "Unsupported TLP" error in case if there is
an attempt to touch a MW frame initialized with port number matching the local
port number. (Internally IDT PCIe-switch is working with port partitions.
But I didn't want to complicate the API description, so we just utilize the
port numbers naming, which is essentially the same as partitions for NTB.)

The biggest drawback of the selected table representation is that the
port-index mapping is unique for each local port, which makes the
indexes unsuitable to distribute shared resources like outbound
MWs, Doorbells and Scratchpads (if one ever implemented for multi-port
NTB devices). For instance each port can access a port with index 0,
which for local port 0 is port 2, while for the rest of the local ports
it's port 0, and so on.

This drawback already caused complications in the ntb_pingpong driver,
where after your patchset acceptance we use port numbers to distribute
the doorbell bits. The same problem is popping up here, but this time
it can't be solved by the port numbers utilization due to the limited number
of MWs available on IDT.

As I already said there can be two ways to get rid of the complication.
One of them is to redefine the port-index table, so to map the port numbers
to global indexes instead of the local ones, like this:

peer port \ local port   0  2  4  6  8  12  16  20
        0                0  0  0  0  0   0   0   0
        2                1  1  1  1  1   1   1   1
        4                2  2  2  2  2   2   2   2
        6                3  3  3  3  3   3   3   3
        8                4  4  4  4  4   4   4   4
       12                5  5  5  5  5   5   5   5
       16                6  6  6  6  6   6   6   6
       20                7  7  7  7  7   7   7   7

By doing so we'll be able to use the port indexes to distribute the
shared resources like MWs, Doorbells and Scratchpads, but we may get
the problem with "Unsupported TLP" error I described before for IDT
devices, if a NTB API client code tries to define a MW pointing to the
local port on IDT NTB hardware. I don't know whether the same problem
exists for Switchtec multi-ports NTB devices, but this approach shall
definitely lead to cleaner and easier NTB API as well as simplify the
IDT NTB hw driver. We also won't need to have any additional tables like
ntb_peer_resource_idx().

(the second solution is described further in the next comment)

> + * For example, if this function is used to program peer's memory
> + * windows, port 0 will program MW 0 on all it's peers to point to itself.
> + * port 1 will program MW 0 in port 0 to point to itself and MW 1 on all
> + * other ports. etc.
> + *
> + * For the legacy two host case, ntb_port_number() and ntb_peer_port_number()
> + * both return zero and therefore this function will always return zero.
> + * So MW 0 on each host would be programmed to point to the other host.
> + *
> + * Return: the resource index to use for that peer.
> + */
> +static inline int ntb_peer_resource_idx(struct ntb_dev *ntb, int pidx)
> +{
> +	int local_port, peer_port;
> +
> +	if (pidx >= ntb_peer_port_count(ntb))
> +		return -EINVAL;
> +
> +	local_port = ntb_port_number(ntb);
> +	peer_port = ntb_peer_port_number(ntb, pidx);
> +
> +	if (peer_port < local_port)
> +		return local_port - 1;
> +	else
> +		return local_port;
> +}
> +

Instead of redefining the port-index table we can just fix the
ntb_peer_resource_idx() method, so it would return a global port index
instead of some number based on the port number. It can be done just by
the next modification:

+     if (peer_port <= local_port)
+             return pidx;
+     else
+             return pidx + 1;


Personally I'd prefer the first solution even though it may lead to the
"Unsupported TLP" errors and cause a greater code changes. Here is why:
1) the error might be IDT-specific, so we shouldn't limit the API due to
one particular hardware peculiarity,
2) port-index table with global indexes implementation shall simplify the IDT
NTB hw driver and provide a cleaner NTB API with simpler shared resources
utilization code.

The final decision is after the NTB subsystem maintainers. If they agree with
solution #1 I'll send a corresponding patchset on this week, so you can
alter this patchset being based on it.

> +/**
> + * ntb_peer_highest_mw_idx() - get a memory window index for a given peer idx
> + *	using the highest index memory windows first
> + *
> + * @ntb:	NTB device context.
> + * @pidx:	Peer port index.
> + *
> + * Like ntb_peer_resource_idx(), except it returns indexes starting with
> + * last memory window index.
> + *
> + * Return: the resource index to use for that peer.
> + */
> +static inline int ntb_peer_highest_mw_idx(struct ntb_dev *ntb, int pidx)
> +{
> +	int ret;
> +
> +	ret = ntb_peer_resource_idx(ntb, pidx);
> +	if (ret < 0)
> +		return ret;
> +
> +	return ntb_mw_count(ntb, pidx) - ret - 1;
> +}
> +
>  #endif
> -- 
> 2.19.0
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/20190213175454.7506-8-logang%40deltatee.com.
> For more options, visit https://groups.google.com/d/optout.

-Sergey
