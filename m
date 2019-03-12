Return-Path: <SRS0=lIFx=RP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD72BC43381
	for <linux-pci@archiver.kernel.org>; Tue, 12 Mar 2019 21:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71412213A2
	for <linux-pci@archiver.kernel.org>; Tue, 12 Mar 2019 21:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbfCLVaV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 12 Mar 2019 17:30:21 -0400
Received: from ale.deltatee.com ([207.54.116.67]:44244 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726396AbfCLVaV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Mar 2019 17:30:21 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1h3oyQ-0006mW-PQ; Tue, 12 Mar 2019 15:30:12 -0600
To:     Serge Semin <fancer.lancer@gmail.com>,
        linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kselftest@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Allen Hubbe <allenbh@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Eric Pilmore <epilmore@gigaio.com>
References: <20190213175454.7506-1-logang@deltatee.com>
 <20190213175454.7506-8-logang@deltatee.com>
 <20190306012420.wjeatxgb7nwq3j5q@mobilestation>
 <bd72f24f-5982-0fe7-59df-2fbbfe9f798a@deltatee.com>
 <20190306224542.4eu2dvsixfzc75gr@mobilestation>
 <4acf79c1-766b-1db6-45c1-4cdd4cbba437@deltatee.com>
 <20190312204223.onyjmyrj2e3e63mr@mobilestation>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <403cad03-27bc-284d-e06c-15460791abe7@deltatee.com>
Date:   Tue, 12 Mar 2019 15:30:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190312204223.onyjmyrj2e3e63mr@mobilestation>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: epilmore@gigaio.com, dave.jiang@intel.com, allenbh@gmail.com, joro@8bytes.org, bhelgaas@google.com, jdmason@kudzu.us, linux-kselftest@vger.kernel.org, iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, fancer.lancer@gmail.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v2 07/12] NTB: Introduce functions to calculate multi-port
 resource index
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-03-12 2:42 p.m., Serge Semin wrote:
> If you don't want to add a large semantic and infrastructure change at
> this point, then it would be better to leave NTB port API the way it is
> now, and use logical port indexes in the ntb_peer_resource_idx() method.
> You'd also need to use this method to access both outbound and inbound
> memory windows. In this case we wouldn't need to change anything in
> current API and drivers. Yes, this approach would cause one resource being
> wasted, but it would lead to simpler semantic of the port numbers API.

Well my proposal would not require any changes in the API, it would just
require a change to the IDT driver. And the mess in the test tools will
still be a mess.


> Sorry man, but how could you base your interpretation on a code, which didn't
> support multi-port case in the first place and just couldn't provide you a full
> impression by definition? You knew ntb_transport doesn't support the multi-port
> NTB devices, right? Moreover as far as I remember we already concerned similar
> problem in a discussion of your patches submitted for ntb_pingpong driver.
> You knew ntb_pingpong and ntb_perf driver support multi-port devices.
> So you could get your interpretation from there.

Yes, but the test drivers were a mess and difficult to follow. Only now
am I realizing that ntb_perf required one too many resources by design,
thus are probably very broken for cases that previously worked because
of it.

> 
> BTW I didn't figure out it at that time, but you could fix the ntb_pingpong
> driver just by replacing the strict inequality in the conditional statement:
> --- a/drivers/ntb/test/ntb_pingpong.c
> +++ b/drivers/ntb/test/ntb_pingpong.c
> @@ -299,7 +299,7 @@ static void pp_init_flds(struct pp_ctx *pp)
>         lport = ntb_port_number(pp->ntb);
>         pcnt = ntb_peer_port_count(pp->ntb);
>         for (pidx = 0; pidx < pcnt; pidx++) {
> -               if (lport < ntb_peer_port_number(pp->ntb, pidx))
> +               if (lport <= ntb_peer_port_number(pp->ntb, pidx))
>                         break;
>         }
> 
> This loop just finds out the logical index (as you named it) of the local port,
> which then is used to select a doorbell bit from the shared doorbell register.
> The similar algo is used in the ntb_perf driver.

Yes, it just feels overly complex to have to do that loop every time.


> Ah, I misunderstood your statement. I thought you implied the other way around.
> I disagree then. Client drivers should be somehow able to retrieve the real physical port
> number. Physical port numbers can be connected with some ports-specific functionality
> (and they are in our projects), so they are used to enable/disable corresponding
> code of the client drivers.

Ok, you're saying that the user will need to be able to map these ports
somehow to their physical address. I buy that, but NTB transport for
example, doesn't really have any method for this. You just get network
interfaces that will likely be numbered similarly to the logical port
number. But that's a whole other problem that will need to be solved
later when there is multi-port ntb-transport.

> You said: "Part of the reason we have this confusing mess is because the API was
> reviewed and merged before any users of the API were presented. Usually this is not
> accepted in kernel development." A source code of my project is using current port
> API and happy with it, so there was at least one user of the API at the time of
> the API submission. I bet there are others now, since I constantly get private questions
> regarding the IDT hardware configurations. So please don't be so judgemental. If you see
> some confusing from your point of view things it doesn't always mean it is a mess,
> you just may misunderstand something. I am sure a pro with experience like yours
> doesn't need this to be explained.

Users of the code that are not in upstream do not count. Developers
cannot look at that code and reason about how the API is supposed to be
used. This isn't being judgemental, it's stating a fact: kernel
developers do not like having incomplete code in upstream[1][2]. When it
happens, it just makes the code very hard to maintain and very hard to
develop on. Many developers call this a disaster and commonly call for
the code in question to be removed. I can understand this completely
because I'm facing the exact same issues trying to work with the current
upstream NTB code.

> - cons:
>   use ntb_peer_resource_idx() method to distribute a shared resource on each side
> of NTB (although it might be neutral or pros from some point of view);
>   waste one memory window (no problem with shared doorbell register).

I think wasting one memory window is a no-go and should never have been
merged in the first place. The code originally worked fine in the
situation where you have 2 peers, each with one memory window, and that
needs to be maintained.

> The rest of the solutions would lead to overcomplications in the NTB port API,
> which we don't want to introduce.

Well, frankly, it's a mess right now so we just have to deal with it and
try to find a short term solution to start fixing it. Complexity be damned.

> Personally after all the considerations I am now more inclined to the (2)-nd
> solution. Even though it causes more changes and makes the ports API
> more abstract, it provides a way to create a simpler shared resources
> distribution code as well as to exactly distribute the necessary number
> of memory windows. While the physical port number still can be found by
> client drivers directly from pci_dev descriptor.

Ok I think, for v3, I'll introduce a logical_port_number helper function
which is essentially the loop you proposed. It's needlessly slow (altho
speed isn't an issue) and ugly but at least, I think, it should be as
close to correct as we can get. Someone else will have to eventually
clean up all the test tools because I suspect they are still broken (but
they at least work for me after my fixup set was merged). I personally
have no interest in working on NTB code anymore unless I am being
contracted to do so.

> The final decision regarding the solution is after the subsystem maintainers.
> But although the provided by this patchset NTB MSI library consists some part
> with multi-port API utilization like MWs distribution, as I said in comments
> to the other patches, it doesn't really support the only multi-ports NTB device
> currently available - IDT (which I only interested in). So I don't see a reason
> why I should bother with providing a patch with alterations to the IDT hardware
> driver unless this patchset provides a portable NTB MSI library.

Yes, well the reason it won't work is because of the current mess which
I don't feel like I should be responsible for sorting out. My code works
 correctly for the existing ntb_transport and I've made a best effort to
get as much multiport support as I feel I can, given the available
infrastructure.

Logan

[1] https://lwn.net/Articles/757124/
[2] https://lwn.net/ml/linux-kernel/20190130075256.GA29665@lst.de/
