Return-Path: <SRS0=lIFx=RP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E24DC43381
	for <linux-pci@archiver.kernel.org>; Tue, 12 Mar 2019 20:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7FC621734
	for <linux-pci@archiver.kernel.org>; Tue, 12 Mar 2019 20:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdzhJM/R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbfCLUmb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 12 Mar 2019 16:42:31 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40885 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727338AbfCLUmb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Mar 2019 16:42:31 -0400
Received: by mail-lf1-f65.google.com with SMTP id u68so3135869lff.7;
        Tue, 12 Mar 2019 13:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2/8TWClb6/ZGEBZ4/LfYdiiSVtSe79aTdWVEcRNb0Ik=;
        b=PdzhJM/RhxcVn9xCEEff4MGDGO07mUli7gjw9M5dL4au/6xlBwRnDm7oWK15yc72uL
         y+nhJ/pe7v6TRQEAtJXVv+ihvm/6Olk+2sI+Pds+6DxqQSPY+kAEzkXYa2MZBJwhXA2q
         BCjWJdF9Np1r3N0z1PGUkwuriFn3nVz2CenwlWC2yGHHiMjTOBCL87dvLAwe1rPYiTCw
         ai2yQhPp0R2eGOAytG93NXK2ICvXmcmHcmikJcXTECcMJHL3i1KTOMUvIn7XrNnfmBRD
         KYSiHxUkRKgLqDBmV8esS8KxvD4+6oI43++Wu+3NMmv2wUifM64xmKfWLqUkK+cMSB21
         gv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=2/8TWClb6/ZGEBZ4/LfYdiiSVtSe79aTdWVEcRNb0Ik=;
        b=Gfx3aRxL09s/IzoxOeT3v4ewLlqAYzbIS9RL4TSHaEbCHOYB9/eaMrV+CQVSfsaeBk
         7MlUiN5QRXO3jvHP+VX9EBgCyiuoVf4qsOPT7sIXcBaxDtbC8fXTWI4QdGXF5UZjXMfN
         erxUMiBnX0zKs5AVd6AHlB675sbVNAPa2lNBEZMi5usz2CwSQxceuZZG21ED7f6QKIvn
         WfZMDTQOAcBadqbN9M/HKab0PWwLzUAS9LPLT6giYLiGwYFbyxGXSe89n0Pzm5/D/V50
         Eya1wx1uds5naJjFjPgcqNjJITIQPPAMEDIxkvrmiv3jgWSplQ9famTEWwBgV2RD0Hrr
         ZD6A==
X-Gm-Message-State: APjAAAWrSdu6+IfvujTV5RNBDGRPxXOemWkqRM0s3p7v0JysVSHpSKs4
        fdjUSh1IqRN8/bWDRCFI8Y8=
X-Google-Smtp-Source: APXvYqyXxfGLXqQpTigq3qCQY5S8151ZXPqQwR6zVOnVDLsRNTirYP47xo66DYFPzesnVvNu6XTGsg==
X-Received: by 2002:a19:691c:: with SMTP id e28mr21177676lfc.86.1552423347830;
        Tue, 12 Mar 2019 13:42:27 -0700 (PDT)
Received: from mobilestation ([95.79.187.182])
        by smtp.gmail.com with ESMTPSA id h3sm1749894lfj.25.2019.03.12.13.42.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 12 Mar 2019 13:42:27 -0700 (PDT)
Date:   Tue, 12 Mar 2019 23:42:24 +0300
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
Message-ID: <20190312204223.onyjmyrj2e3e63mr@mobilestation>
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
 <20190306012420.wjeatxgb7nwq3j5q@mobilestation>
 <bd72f24f-5982-0fe7-59df-2fbbfe9f798a@deltatee.com>
 <20190306224542.4eu2dvsixfzc75gr@mobilestation>
 <4acf79c1-766b-1db6-45c1-4cdd4cbba437@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4acf79c1-766b-1db6-45c1-4cdd4cbba437@deltatee.com>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 06, 2019 at 04:22:33PM -0700, Logan Gunthorpe wrote:
> 
> On 2019-03-06 3:45 p.m., Serge Semin wrote:
> [Snip]
> 
> Pretty sure everything above is just agreement...
> 
> > So your current approach is inbound MW-centralized, while mine is developed
> > around the outbound MWs.
> 
> I don't think this has anything to do with inbound vs outbound. The
> problem is the same no matter from which direction you assign things.
> 
> >> Physical Port Number: 0  2  4  6  8  12  16  20
> >> Logical Port Number:  0  1  2  3  4  5   6   7
> >> Peer Index (Port 0):  x  0  1  2  3  4   5   6
> >> Port Index (Port 8):  0  1  2  3  x  4   5   6
> >> (etc)
> > 
> > That's what I suggested in the two possible solutions:
> > 1st solution: replace current pidx with Logical Port Number,
> > 2nd solution: alter ntb_peer_resource_idx() so it would return the Logical Port Number.
> 
> Well my solution wasn't to change pidx and no, we don't want to change
> ntb_peer_resource_idx() to return the logical port number because that's
> not how it's being used and I have no use for a
> ntb_peer_port_global_idx() function. Functions are supposed to be added
> by code that needs to call them, not by some grand design. Part of the
> reason we have this confusing mess is because the API was reviewed and
> merged before any users of the API were presented. Usually this is not
> accepted in kernel development.
> 
> My suggestion is to simply say that the existing port numbers are the
> logical port number and have the drivers handle the physical port number
> mapping internally. That requires the fewest changes.
> 

Now I see what you were suggesting. The solution you propose doesn't require
any changes in your patches, but requires to update IDT driver. It also
makes a change in the ports numbering semantics, which you said you
didn't want to introduce.
(read all further comments to get my conclusion regarding it)

> > IMO In case of the 2nd solution I'd also suggest to rename the
> > ntb_peer_resource_idx() method into ntb_peer_port_global_idx(),
> > and then consider the current port indexes used in the NTB API
> > as local port indexes. The resource indexing can be abstracted
> > by a macro like this:
> > #define ntb_peer_resource_idx ntb_peer_port_global_idx
> 
> That define would not be useful.
> 
> > Finally in order to close the space up we'd also need to define
> > a method: ntb_port_global_idx(), which would return a Logical (global)
> > index of local port.
> 
> Again, I'd rather not add a bunch of large semantic and infrastructure
> changes at this point. It's confusing enough as it is and we don't need
> to introduce yet another indexing scheme API to the clients that really
> do not need it. What the clients need is a simple API to decide which
> resources to use for which peers, and to figure out which peers used
> which resources. ntb_peer_port_idx() and ntb_peer_resource_idx() suit
> these purposes. Nothing else really needs to exist.
> 

If you don't want to add a large semantic and infrastructure change at
this point, then it would be better to leave NTB port API the way it is
now, and use logical port indexes in the ntb_peer_resource_idx() method.
You'd also need to use this method to access both outbound and inbound
memory windows. In this case we wouldn't need to change anything in
current API and drivers. Yes, this approach would cause one resource being
wasted, but it would lead to simpler semantic of the port numbers API.

Don't get me wrong. I am not completely against the approach you suggest.
It just has its pros and cons. The same way as mine does. I'll explain my
opinion later in this email.

> >> Where the Physical Port Number is whatever the hardware uses and the
> >> logical port number is a numbering scheme starting with zero with no
> >> gaps. Then the port indexes are still as we currently have them. If we
> >> say that the port numbers we have now are the Logical Port Number, then
> >> ntb_peer_resource_idx() is correct.
> >>
> > 
> > Current port numbers are the physical port numbers with gaps. 
> 
> I think that's up for interpretation as, based on the existing code, I
> naturally interpreted it the other way and therefore it's pretty simple
> to say that it's the logical port number and fix the one driver that
> needs to change.
> 
> > That's why we
> > introduced the port-index NTB API abstraction in the first place, to have these gaps
> > eliminated and to provide a simple way of bulk setup. Although that abstraction
> > turned out not that suitable to distribute the shared resources. So
> > the Logical (Global) indexing is needed to do it (that's what ntb_pingpong used
> > to do and ntb_perf still does now).
> 
> My interpretation of the port-index was simply to match what was done in
> the two port case seeing code like ntb_transport simply uses the default
> 0 as the port index. There was no reason to believe, based on the code,
> that there would be gaps.
> 

Sorry man, but how could you base your interpretation on a code, which didn't
support multi-port case in the first place and just couldn't provide you a full
impression by definition? You knew ntb_transport doesn't support the multi-port
NTB devices, right? Moreover as far as I remember we already concerned similar
problem in a discussion of your patches submitted for ntb_pingpong driver.
You knew ntb_pingpong and ntb_perf driver support multi-port devices.
So you could get your interpretation from there.

BTW I didn't figure out it at that time, but you could fix the ntb_pingpong
driver just by replacing the strict inequality in the conditional statement:
--- a/drivers/ntb/test/ntb_pingpong.c
+++ b/drivers/ntb/test/ntb_pingpong.c
@@ -299,7 +299,7 @@ static void pp_init_flds(struct pp_ctx *pp)
        lport = ntb_port_number(pp->ntb);
        pcnt = ntb_peer_port_count(pp->ntb);
        for (pidx = 0; pidx < pcnt; pidx++) {
-               if (lport < ntb_peer_port_number(pp->ntb, pidx))
+               if (lport <= ntb_peer_port_number(pp->ntb, pidx))
                        break;
        }

This loop just finds out the logical index (as you named it) of the local port,
which then is used to select a doorbell bit from the shared doorbell register.
The similar algo is used in the ntb_perf driver.

> >> I would strongly argue that the clients don't need to know anything
> >> about the Physical Port Number and these should be handled strictly
> >> inside the drivers. If multiple drivers need to do something similar to
> >> map the logical to physical port numbers then we should introduce helper
> >> functions to allow them to do so. If the Physical Numbers are not
> >> contained in the driver than the API would need to be expanded to expose
> >> which numbers are actually used to avoid needing to constantly loop
> >> through all the indexes to find this out.
> >>
> > 
> > Absolutely agree with you. The main idea of NTB API was to provide a set
> > of methods to access the NTB hardware without any abstractions but
> > with possible useful helpers, like your NTB MSI library, or transport library,
> > or anything else. So the physical port numbers must be available for
> > the client drivers.
> 
> Huh? How can you say you absolutely agree with me? I said the clients
> should not need to know about physical port numbers and you said the
> physical port numbers *must* be available to clients. I think this
> statement needs to be justified. Why should the clients need to know
> about the physical port numbers?
> 

Ah, I misunderstood your statement. I thought you implied the other way around.
I disagree then. Client drivers should be somehow able to retrieve the real physical port
number. Physical port numbers can be connected with some ports-specific functionality
(and they are in our projects), so they are used to enable/disable corresponding
code of the client drivers.

Additionally IDT PCIe NTB functions can be disabled/enabled by the device firmware,
so one device may have for instance ports 2 4 6 with NTB, while another - ports 2 6 12,
and so on. Both of these ports-set would be mapped to the same logical indexes space -
0 1 2. In case of having just the logical indexes, the code would have an impression
of working with the same hardware, while in fact it isn't.

You said: "Part of the reason we have this confusing mess is because the API was
reviewed and merged before any users of the API were presented. Usually this is not
accepted in kernel development." A source code of my project is using current port
API and happy with it, so there was at least one user of the API at the time of
the API submission. I bet there are others now, since I constantly get private questions
regarding the IDT hardware configurations. So please don't be so judgemental. If you see
some confusing from your point of view things it doesn't always mean it is a mess,
you just may misunderstand something. I am sure a pro with experience like yours
doesn't need this to be explained.

> >> On a similar vein, I'd  suggest that most clients shouldn't even really
> >> need to do anything with the Logical Port Number and should deal largely
> >> with Port Indexes. Ideally, Logical Port Numbers should only be used by
> >> helper code in the common layer to help assign resources used by the
> >> clients (like ntb_peer_resource_idx()).
> >>
> > 
> > This is the main question. Do we really need the current port indexes
> > implementation at all? After all these years of NTB API usage I don't really
> > see it useful in any case except to loop over the outbound MW resources
> > automatically skipping the local port (usefulness of this is also questionable).
> > As I already said I created the port-index table this way due to the IDT NTB
> > MWs peculiarity, which doesn't seem to me a big problem now comparing to all
> > these additional complications we intend to introduce.
> 
> To me, it seems like the port indexes are used everywhere. A client
> almost always wants to deal with every port except itself. That seems
> entirely natural to me. Using the port index as the resource index makes
> perfect sense (which is why I implemented the inverse
> ntb_peer_resource_idx()).
> 
> > The rest of the drivers code really need to have the Logical (global)
> > port indexes, at least to distribute the shared resources, and don't use
> > the current pidx that much.
> 
> Drivers don't care about port indexes or how the resources are
> distributed. I would expect that all they'd do is map the port index
> (which all existing APIs take) to the physical address and program
> hardware as necessary.
> 
> > Wouldn't it be better to just redefine the current port-index table
> > in the following way?
> > ntb_port_number() - local physical port number,
> > ntb_port_idx() - local port logical (global) index,
> > ntb_peer_port_count() - total number of ports NTB device provide (including the local one),
> > ntb_peer_port_number() - physical port number of the peer with passed logical port index,
> > ntb_peer_port_idx - logical port index of the passed physical port number.
> 
> No, from the perspective of the client, the physical port numbers are
> useless. I don't want the count to include the local one because that
> means I'd always have to subtract one every time I want to loop through
> all peers (I never want to loop through all ports including the local
> one).  I have no idea what your distinction between logical (global)
> index and logical port index is. In fact I find this all confusing.
> 
> > while currently we have:
> > ntb_port_number() - local physical port number,
> > ntb_peer_port_count() - total number of ports NTB device provide (excluding the local one),
> > ntb_peer_port_number() - physical port number of the peer with passed port index,
> > ntb_peer_port_idx - port index of the passed physical port number;
> 
> What we currently have all makes perfect sense to me and is exactly what
> I want for the clients, except I think ntb_port_number() needs to be the
> logical port number (with the gaps removed), so that we can more easily
> implement ntb_peer_resource_idx(). If ntb_port_number() corresponds to
> the physical port number, then the correct implementation of
> ntb_peer_resource_idx() is going to be crazy, essentially needing to
> generate a logical port number for every port, every time it's called.
> 
> Logan
> 

To sum the discussion up we now have two possible solutions of the problem
discovered in this patch:

1) Leave current NTB port API as is, but fix this patch so the ntb_peer_resource_idx()
method would return a port logical index:
Physical port numbers: 0 2 4 6 8 12 16 20 (ntb_peer_port_number()/ntb_port_number())
Logical port numbers:  0 1 2 3 4  5  6  7 (ntb_peer_resource_idx())
Port indexes (Port 0): x 0 1 2 3  4  5  6 (ntb_peer_port_idx())
Port indexes (Port 8): 0 1 2 3 x  4  5  6 (ntb_peer_port_idx())
+ pros:
  no need to change current NTB port API and available drivers;
  no need to apply the gap-less limitation on the NTB port numbers sequence;
- cons:
  use ntb_peer_resource_idx() method to distribute a shared resource on each side
of NTB (although it might be neutral or pros from some point of view);
  waste one memory window (no problem with shared doorbell register).

2) Apply the gap-less limitation on the NTB port numbers sequence, so the
ntb_peer_port_number()/ntb_port_number() would return the logical port index:
Physical port numbers: 0 2 4 6 8 12 16 20 (no NTB API method to get these numbers)
Logical port numbers:  0 1 2 3 4  5  6  7 (ntb_peer_port_number()/ntb_port_number())
Port indexes (Port 0): x 0 1 2 3  4  5  6 (ntb_peer_port_idx())
Port indexes (Port 8): 0 1 2 3 x  4  5  6 (ntb_peer_port_idx())
+ pros:
  no waste of one memory window;
  use port numbers returned from ntb_peer_port_number()//ntb_port_number()
to distribute doorbell bits and outbound MWs;
  use ntb_peer_resource_idx() just at the peer side to select a proper inbound MW;
- cons:
  need to change the port-index callbacks of the IDT hardware driver;
  introduces a change in the port numbers semantic;
  NTB port API gets to be an abstraction over the real physical port numbers,
while the later ones won't de directly available to retrieve.


The rest of the solutions would lead to overcomplications in the NTB port API,
which we don't want to introduce.

Personally after all the considerations I am now more inclined to the (2)-nd
solution. Even though it causes more changes and makes the ports API
more abstract, it provides a way to create a simpler shared resources
distribution code as well as to exactly distribute the necessary number
of memory windows. While the physical port number still can be found by
client drivers directly from pci_dev descriptor.

The final decision regarding the solution is after the subsystem maintainers.
But although the provided by this patchset NTB MSI library consists some part
with multi-port API utilization like MWs distribution, as I said in comments
to the other patches, it doesn't really support the only multi-ports NTB device
currently available - IDT (which I only interested in). So I don't see a reason
why I should bother with providing a patch with alterations to the IDT hardware
driver unless this patchset provides a portable NTB MSI library.

-Sergey

> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/4acf79c1-766b-1db6-45c1-4cdd4cbba437%40deltatee.com.
> For more options, visit https://groups.google.com/d/optout.
